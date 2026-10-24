import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

const _environmentUrl = "POCKETBASE_URL";
const _environmentUserId = "LEGACY_USER_ID";
const _environmentToken = "POCKETBASE_TOKEN";
const _environmentEmail = "POCKETBASE_ADMIN_EMAIL";
const _environmentPassword = "POCKETBASE_ADMIN_PASSWORD";

const _defaultOutputPath = "out/legacy_backup.zip";
const _pageSize = 500;
const _jsonIndent = "  ";
const _exitUsage = 64;
const _exitFailure = 1;

const _formatName = "vocabualize-backup";
const _formatVersion = 1;
const _sourceName = "legacy-pocketbase";

const _collectionUsers = "users";
const _collectionLanguages = "languages";
const _collectionTags = "tags";
const _collectionVocabularies = "vocabularies";

const _imageKindCustom = "custom";
const _imageKindStock = "stock";
const _activityTypePractice = "practice";
const _activityTypeAdd = "add";

const _defaultLevel = 0.0;
const _defaultIsNovice = true;
const _defaultIntervalMinutes = 1440;
const _defaultEase = 2.5;

const _yearDigits = 4;
const _monthDayDigits = 2;

class const _ExportException(final String message) implements Exception;

typedef _Record = Map<String, Object?>;

Future<void> main(List<String> arguments) async {
  final environment = Platform.environment;
  final baseUrl = environment[_environmentUrl];
  final userId = environment[_environmentUserId];
  if (baseUrl == null || userId == null) {
    stderr.writeln(
      "Set $_environmentUrl and $_environmentUserId, plus either $_environmentToken "
      "or $_environmentEmail and $_environmentPassword.",
    );
    exitCode = _exitUsage;
    return;
  }
  final outputPath = arguments.isEmpty ? _defaultOutputPath : arguments.first;
  final client = HttpClient();
  try {
    final api = _PocketBaseApi(
      client,
      Uri.parse(
        baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl,
      ),
    );
    final token = environment[_environmentToken] ?? await api.authenticate(environment);
    await _export(api, token, userId, outputPath);
  } on _ExportException catch (exception) {
    stderr.writeln(exception.message);
    exitCode = _exitFailure;
  } on IOException catch (exception) {
    stderr.writeln("Network or file error: $exception");
    exitCode = _exitFailure;
  } on FormatException catch (exception) {
    stderr.writeln("Unexpected response: ${exception.message}");
    exitCode = _exitFailure;
  } finally {
    client.close();
  }
}

Future<void> _export(
  _PocketBaseApi api,
  String token,
  String userId,
  String outputPath,
) async {
  final userFilter = "user='$userId'";
  final user = await api.getRecord(token, _collectionUsers, userId);
  final languages = await api.listRecords(token, _collectionLanguages);
  final tags = await api.listRecords(
    token,
    _collectionTags,
    filter: userFilter,
  );
  final vocabularies = await api.listRecords(
    token,
    _collectionVocabularies,
    filter: userFilter,
  );
  final fileToken = await api.fileToken(token);

  final languageCodes = {
    for (final language in languages)
      language.readString("id"): language.readString("translatorId").toLowerCase(),
  };

  final archive = Archive();
  final exportedVocabularies = <_Record>[];
  final missingImages = <String>[];
  var customImageCount = 0;
  var stockImageCount = 0;

  for (final vocabulary in vocabularies) {
    final id = vocabulary.readString("id");
    final customImageName = vocabulary.readString("customImage");
    _Record? image;
    if (customImageName.isNotEmpty) {
      final bytes = await api.downloadFile(
        _collectionVocabularies,
        id,
        customImageName,
        fileToken,
      );
      if (bytes == null) {
        missingImages.add(id);
      } else {
        final path = "images/$id${customImageName.toExtension()}";
        archive.addFile(ArchiveFile.bytes(path, bytes));
        image = {"kind": _imageKindCustom, "path": path};
        customImageCount++;
      }
    } else {
      image = vocabulary["stockImage"].toStockImage();
      if (image != null) stockImageCount++;
    }
    exportedVocabularies.add({
      "id": id,
      "source": vocabulary.readString("source"),
      "target": vocabulary.readString("target"),
      "sourceLanguageCode": languageCodes[vocabulary.readString("sourceLanguage")],
      "targetLanguageCode": languageCodes[vocabulary.readString("targetLanguage")],
      "tagIds": vocabulary.readStrings("tags"),
      "level": vocabulary.readDouble("levelValue", _defaultLevel),
      "isNovice": vocabulary.readBool("isNovice", _defaultIsNovice),
      "intervalMinutes": vocabulary.readInt(
        "interval",
        _defaultIntervalMinutes,
      ),
      "ease": vocabulary.readDouble("ease", _defaultEase),
      "nextReviewAt": vocabulary.readUtcIsoString("nextDate"),
      "createdAt": vocabulary.readUtcIsoString("created"),
      "updatedAt": vocabulary.readUtcIsoString("updated"),
      "image": image,
    });
  }

  final activities = _activities(user, exportedVocabularies);
  final manifest = {
    "format": _formatName,
    "version": _formatVersion,
    "source": _sourceName,
    "createdAt": DateTime.now().toUtc().toIso8601String(),
    "settings": {
      "sourceLanguageCode": languageCodes[user.readString("sourceLanguageId")],
      "targetLanguageCode": languageCodes[user.readString("targetLanguageId")],
    },
    "counts": {
      "vocabularies": exportedVocabularies.length,
      "tags": tags.length,
      "customImages": customImageCount,
      "stockImages": stockImageCount,
      "activities": activities.length,
    },
    "missingImages": missingImages,
  };
  final exportedTags = [
    for (final tag in tags) {"id": tag.readString("id"), "name": tag.readString("name")},
  ];

  const encoder = JsonEncoder.withIndent(_jsonIndent);
  archive
    ..addFile(ArchiveFile.string("manifest.json", encoder.convert(manifest)))
    ..addFile(ArchiveFile.string("tags.json", encoder.convert(exportedTags)))
    ..addFile(
      ArchiveFile.string(
        "vocabularies.json",
        encoder.convert(exportedVocabularies),
      ),
    )
    ..addFile(
      ArchiveFile.string("activities.json", encoder.convert(activities)),
    );

  final output = File(outputPath);
  await output.parent.create(recursive: true);
  await output.writeAsBytes(ZipEncoder().encodeBytes(archive));

  stdout
    ..writeln("Wrote ${output.absolute.path}")
    ..writeln("  vocabularies:  ${exportedVocabularies.length}")
    ..writeln("  tags:          ${tags.length}")
    ..writeln("  custom images: $customImageCount")
    ..writeln("  stock images:  $stockImageCount")
    ..writeln("  activities:    ${activities.length}")
    ..writeln("  missing images: ${missingImages.length}");
}

List<_Record> _activities(_Record user, List<_Record> vocabularies) {
  final entries = <(String, String)>{};
  final streak = user.readInt("streak", 0);
  final lastActive = DateTime.tryParse(
    user.readString("lastActive").replaceFirst(" ", "T"),
  );
  if (lastActive != null) {
    final lastActiveLocal = lastActive.toLocal();
    for (var offset = 0; offset < streak; offset++) {
      final day = DateTime(
        lastActiveLocal.year,
        lastActiveLocal.month,
        lastActiveLocal.day - offset,
      );
      entries.add((day.toDateString(), _activityTypePractice));
    }
  }
  for (final vocabulary in vocabularies) {
    if (vocabulary["createdAt"] case final String createdAt) {
      entries.add((
        DateTime.parse(createdAt).toLocal().toDateString(),
        _activityTypeAdd,
      ));
    }
  }
  final sorted = entries.toList()..sort((first, second) => first.$1.compareTo(second.$1));
  return [
    for (final (localDate, type) in sorted) {"localDate": localDate, "type": type},
  ];
}

class const _PocketBaseApi(final HttpClient _client, final Uri _baseUri) {
  Future<String> authenticate(Map<String, String> environment) async {
    final email = environment[_environmentEmail];
    final password = environment[_environmentPassword];
    if (email == null || password == null) {
      throw const _ExportException(
        "Set $_environmentToken, or $_environmentEmail and $_environmentPassword.",
      );
    }
    final body = {"identity": email, "password": password};
    for (final path in [
      "/api/collections/_superusers/auth-with-password",
      "/api/admins/auth-with-password",
    ]) {
      final response = await _send("POST", _uri(path), body: body);
      if (response case (_, {"token": final String token})) return token;
    }
    throw const _ExportException(
      "Admin sign-in failed on both the superuser and the admin endpoint.",
    );
  }

  Future<_Record> getRecord(String token, String collection, String id) async {
    final response = await _send(
      "GET",
      _uri("/api/collections/$collection/records/$id"),
      token: token,
    );
    return switch (response) {
      (HttpStatus.ok, final _Record record) => record,
      (final status, _) => throw _ExportException(
        "Reading $collection/$id failed with $status.",
      ),
    };
  }

  Future<List<_Record>> listRecords(
    String token,
    String collection, {
    String? filter,
  }) async {
    final records = <_Record>[];
    for (var page = 1; ; page++) {
      final uri = _uri("/api/collections/$collection/records", {
        "page": "$page",
        "perPage": "$_pageSize",
        "filter": ?filter,
      });
      final items = switch (await _send("GET", uri, token: token)) {
        (HttpStatus.ok, {"items": final List<Object?> items}) =>
          items.whereType<_Record>().toList(),
        (final status, _) => throw _ExportException(
          "Listing $collection failed with $status.",
        ),
      };
      records.addAll(items);
      if (items.length < _pageSize) return records;
    }
  }

  Future<String?> fileToken(String token) async {
    final response = await _send(
      "POST",
      _uri("/api/files/token"),
      token: token,
    );
    return switch (response) {
      (HttpStatus.ok, {"token": final String fileToken}) => fileToken,
      _ => null,
    };
  }

  Future<Uint8List?> downloadFile(
    String collection,
    String recordId,
    String fileName,
    String? fileToken,
  ) async {
    final uri = _uri("/api/files/$collection/$recordId/$fileName", {
      "token": ?fileToken,
    });
    final response = await (await _client.getUrl(uri)).close();
    if (response.statusCode != HttpStatus.ok) {
      await response.drain<void>();
      return null;
    }
    final builder = BytesBuilder(copy: false);
    await response.forEach(builder.add);
    return builder.takeBytes();
  }

  Uri _uri(String path, [Map<String, String>? queryParameters]) {
    return _baseUri.replace(
      path: "${_baseUri.path}$path",
      queryParameters: queryParameters == null || queryParameters.isEmpty ? null : queryParameters,
    );
  }

  Future<(int, Object?)> _send(
    String method,
    Uri uri, {
    String? token,
    _Record? body,
  }) async {
    final request = await _client.openUrl(method, uri);
    if (token != null) {
      request.headers.set(HttpHeaders.authorizationHeader, token);
    }
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
    }
    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    final json = text.isEmpty ? null : jsonDecode(text);
    return (response.statusCode, json);
  }
}

extension _RecordExtensions on _Record {
  String readString(String key) => switch (this[key]) {
    final String value => value,
    _ => "",
  };

  List<String> readStrings(String key) => switch (this[key]) {
    final List<Object?> values =>
      values.whereType<String>().where((value) => value.isNotEmpty).toList(),
    _ => const [],
  };

  double readDouble(String key, double fallback) => switch (this[key]) {
    final num value => value.toDouble(),
    _ => fallback,
  };

  int readInt(String key, int fallback) => switch (this[key]) {
    final num value => value.toInt(),
    _ => fallback,
  };

  bool readBool(String key, bool fallback) => switch (this[key]) {
    final bool value => value,
    _ => fallback,
  };

  String? readUtcIsoString(String key) {
    final text = readString(key);
    if (text.isEmpty) return null;
    return DateTime.tryParse(text.replaceFirst(" ", "T"))?.toUtc().toIso8601String();
  }
}

extension _StockImageExtensions on Object? {
  _Record? toStockImage() {
    if (this case final _Record image) {
      if (image["src"] case final _Record sources) {
        return {
          "kind": _imageKindStock,
          "pexelsId": "${image["id"]}",
          "url": sources["large"] ?? sources["original"],
          "thumbUrl": sources["tiny"] ?? sources["small"],
          "photographer": image["photographer"],
          "photographerUrl": image["photographerUrl"] ?? image["photographer_url"],
        };
      }
    }
    return null;
  }
}

extension _FileNameExtensions on String {
  String toExtension() {
    final dotIndex = lastIndexOf(".");
    return dotIndex < 0 ? "" : substring(dotIndex).toLowerCase();
  }
}

extension _DateTimeExtensions on DateTime {
  String toDateString() {
    final yearText = "$year".padLeft(_yearDigits, "0");
    final monthText = "$month".padLeft(_monthDayDigits, "0");
    final dayText = "$day".padLeft(_monthDayDigits, "0");
    return "$yearText-$monthText-$dayText";
  }
}
