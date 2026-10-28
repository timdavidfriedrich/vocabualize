import 'package:dart_mappable/dart_mappable.dart';

part 'remote_account.mapper.dart';

@MappableClass()
class const RemoteAccount({
  required final String id,
  required final String? fullName,
  required final String? email,
  required final String? pictureUrl,
}) with RemoteAccountMappable;
