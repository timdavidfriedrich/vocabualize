import 'package:dart_mappable/dart_mappable.dart';

part 'local_account_metadata.mapper.dart';

@MappableClass()
class const LocalAccountMetadata({
  required final String accountId,
  required final String? name,
  required final String? email,
  required final bool hasCompletedInitialSync,
}) with LocalAccountMetadataMappable;
