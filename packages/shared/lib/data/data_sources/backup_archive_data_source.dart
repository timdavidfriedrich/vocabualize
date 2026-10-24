import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/data/models/local_backup.dart';

const _backupFormat = "vocabualize-backup";
const _backupVersion = 1;
const _appSource = "app";
const _manifestFileName = "manifest.json";
const _vocabulariesFileName = "vocabularies.json";
const _tagsFileName = "tags.json";
const _activitiesFileName = "activities.json";
const _imagesFolderName = "images";
const _exportsFolderName = "backup_exports";
const _importsFolderName = "backup_imports";
const _archivePrefix = "vocabualize_backup_";
const _archiveExtension = ".zip";
const _countVocabularies = "vocabularies";
const _countTags = "tags";
const _countImages = "images";
const _countActivities = "activities";
const _documentFileNames = {
  _manifestFileName,
  _vocabulariesFileName,
  _tagsFileName,
  _activitiesFileName,
};
final _imageFileNamePattern = RegExp(r"^[A-Za-z0-9_-]+\.(jpe?g|png|webp)$");

abstract class BackupArchiveDataSource {
  Future<LocalBackupArchive> readArchive(String archivePath);

  Future<String?> findImageFile(LocalBackupArchive archive, String imagePath);

  String imageEntryPath(String localImagePath);

  Future<String> writeArchive({
    required LocalBackupContents contents,
    required Map<String, String> images,
    required List<String> missingImages,
  });

  Future<void> deleteArchive(LocalBackupArchive archive);
}

@Injectable(as: BackupArchiveDataSource)
class const BackupArchiveDataSourceImpl() implements BackupArchiveDataSource {
  @override
  Future<LocalBackupArchive> readArchive(String archivePath) async {
    final directory = Directory(
      "${(await getTemporaryDirectory()).path}/$_importsFolderName/"
      "${DateTime.now().microsecondsSinceEpoch}",
    );
    await directory.create(recursive: true);
    final documents = await Isolate.run(() => _extractArchive(archivePath, directory.path));
    try {
      final manifest = LocalBackupManifestMapper.fromJson(_document(documents, _manifestFileName));
      if (manifest.format != _backupFormat || manifest.version != _backupVersion) {
        throw const FormatException("Unsupported backup format.");
      }
      return LocalBackupArchive(
        directoryPath: directory.path,
        contents: LocalBackupContents(
          vocabularies: _decodeList(
            _document(documents, _vocabulariesFileName),
            LocalBackupVocabularyMapper.fromMap,
          ),
          tags: _decodeList(_document(documents, _tagsFileName), LocalBackupTagMapper.fromMap),
          activities: _decodeList(
            _document(documents, _activitiesFileName),
            LocalBackupActivityMapper.fromMap,
          ),
        ),
      );
    } on MapperException catch (error) {
      await directory.delete(recursive: true);
      throw FormatException(error.message);
    } on FormatException {
      await directory.delete(recursive: true);
      rethrow;
    }
  }

  @override
  Future<String?> findImageFile(LocalBackupArchive archive, String imagePath) async {
    final segments = imagePath.split("/");
    if (segments case [_imagesFolderName, final fileName]
        when _imageFileNamePattern.hasMatch(fileName)) {
      final file = File("${archive.directoryPath}/$_imagesFolderName/$fileName");
      return await file.exists() ? file.path : null;
    }
    return null;
  }

  @override
  String imageEntryPath(String localImagePath) =>
      "$_imagesFolderName/${File(localImagePath).uri.pathSegments.last}";

  @override
  Future<String> writeArchive({
    required LocalBackupContents contents,
    required Map<String, String> images,
    required List<String> missingImages,
  }) async {
    final directory = Directory("${(await getTemporaryDirectory()).path}/$_exportsFolderName");
    if (await directory.exists()) await directory.delete(recursive: true);
    await directory.create(recursive: true);
    final now = DateTime.now();
    final archivePath =
        "${directory.path}/$_archivePrefix${now.toIso8601String().substring(0, 10)}$_archiveExtension";
    final manifest = LocalBackupManifest(
      format: _backupFormat,
      version: _backupVersion,
      source: _appSource,
      createdAt: now.toUtc(),
      counts: {
        _countVocabularies: contents.vocabularies.length,
        _countTags: contents.tags.length,
        _countImages: images.length,
        _countActivities: contents.activities.length,
      },
      missingImages: missingImages,
    );
    final documents = {
      _manifestFileName: manifest.toJson(),
      _vocabulariesFileName: jsonEncode([for (final item in contents.vocabularies) item.toMap()]),
      _tagsFileName: jsonEncode([for (final item in contents.tags) item.toMap()]),
      _activitiesFileName: jsonEncode([for (final item in contents.activities) item.toMap()]),
    };
    await Isolate.run(() => _writeArchive(archivePath, documents, images));
    return archivePath;
  }

  @override
  Future<void> deleteArchive(LocalBackupArchive archive) async {
    final directory = Directory(archive.directoryPath);
    if (await directory.exists()) await directory.delete(recursive: true);
  }

  String _document(Map<String, String> documents, String fileName) =>
      documents[fileName] ?? (throw FormatException("The backup has no $fileName."));

  List<T> _decodeList<T>(String document, T Function(Map<String, dynamic> map) fromMap) {
    return switch (jsonDecode(document)) {
      final List<dynamic> items => [
        for (final item in items)
          item is Map<String, dynamic>
              ? fromMap(item)
              : throw const FormatException("A backup entry is not an object."),
      ],
      _ => throw const FormatException("A backup document is not a list."),
    };
  }
}

Map<String, String> _extractArchive(String archivePath, String directoryPath) {
  final input = InputFileStream(archivePath);
  try {
    final archive = ZipDecoder().decodeStream(input);
    final documents = <String, String>{};
    Directory("$directoryPath/$_imagesFolderName").createSync(recursive: true);
    for (final file in archive) {
      if (!file.isFile) continue;
      final segments = file.name.split("/");
      if (_documentFileNames.contains(file.name)) {
        documents[file.name] = utf8.decode(file.readBytes() ?? const []);
      } else if (segments case [_imagesFolderName, final fileName]
          when _imageFileNamePattern.hasMatch(fileName)) {
        final output = OutputFileStream("$directoryPath/$_imagesFolderName/$fileName");
        file.writeContent(output);
        output.closeSync();
      }
    }
    return documents;
  } finally {
    input.closeSync();
  }
}

void _writeArchive(String archivePath, Map<String, String> documents, Map<String, String> images) {
  final encoder = ZipFileEncoder()..create(archivePath);
  for (final MapEntry(key: name, value: content) in documents.entries) {
    encoder.addArchiveFile(ArchiveFile.string(name, content));
  }
  for (final MapEntry(key: name, value: sourcePath) in images.entries) {
    encoder.addFileSync(File(sourcePath), name);
  }
  encoder.closeSync();
}
