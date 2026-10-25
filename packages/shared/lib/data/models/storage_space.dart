import 'package:dart_mappable/dart_mappable.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

part 'storage_space.mapper.dart';

@MappableClass()
sealed class StorageSpace with StorageSpaceMappable {
  const StorageSpace();
}

@MappableClass()
class const LocalOnlySpace() extends StorageSpace with LocalOnlySpaceMappable;

@MappableClass()
class const AccountSpace({
  required final UuidValue userId,
}) extends StorageSpace with AccountSpaceMappable;
