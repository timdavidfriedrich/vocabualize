import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/extensions/string_extensions.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';

extension AuthStoreMappers on AuthStore {
  AppUser? toAppUser() {
    final record = model is RecordModel? ? model as RecordModel? : null;
    return record?.toAppUser();
  }
}

extension AuthStoreEventMappers on AuthStoreEvent {
  AppUser? toAppUser() {
    final record = model is RecordModel? ? model as RecordModel? : null;
    return record?.toAppUser();
  }
}

extension _AuthRecordModelMappers on RecordModel {
  AppUser? toAppUser() {
    final avatarFileName = getDataValue<String?>("avatar")?.takeUnless((url) {
      return url.isEmpty;
    });
    return AppUser(
      id: id,
      username: getDataValue<String?>("username"),
      name: getStringValue("name", "Anonymous"),
      email: getDataValue<String?>("email"),
      emailVisibility: getDataValue<bool?>("emailVisibility"),
      verified: getDataValue<bool?>("verified"),
      avatarUrl: avatarFileName?.toFileUrl(id, collectionName),
      created: DateTime.tryParse(created),
      updated: DateTime.tryParse(updated),
    );
  }
}
