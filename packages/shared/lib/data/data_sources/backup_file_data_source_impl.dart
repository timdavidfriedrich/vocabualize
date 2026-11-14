import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/data/data_sources/backup_file_data_source.dart';

const _archiveExtension = "zip";

@Injectable(as: BackupFileDataSource)
class const BackupFileDataSourceImpl() implements BackupFileDataSource {
  @override
  Future<String?> pickArchive() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const [_archiveExtension],
    );
    return file?.path;
  }

  @override
  Future<void> shareArchive(String archivePath) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(archivePath)]));
  }

  @override
  Future<void> clearPickedArchives() => FilePicker.clearTemporaryFiles();
}
