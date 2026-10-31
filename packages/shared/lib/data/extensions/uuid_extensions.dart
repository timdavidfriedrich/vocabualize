import 'package:vocabualize_client/vocabualize_client.dart';

const _languageRowNamespace = "2f6b9a1e-8c4d-4e7a-9b3f-6d1c0e5a7f42";

extension UuidValueExtensions on UuidValue {
  UuidValue languageRowId(String languageCode) =>
      const Uuid().v5obj(_languageRowNamespace, "$uuid/$languageCode");
}
