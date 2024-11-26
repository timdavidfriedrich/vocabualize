import 'package:vocabualize/constants/secrets/pocketbase_secrets.dart';

extension StringExtensions on String {
  // TODO: Remove String.toFileUrl() extension and find an alternative using pb.files.getUrl(record, filename)
  String toFileUrl(String recordId, String collectionName) {
    return "${PocketbaseSecrets.databaseUrl}/api/files/$collectionName/$recordId/$this";
  }
}
