import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';

extension AuthStoreMappers on AuthStore {
  AppUser? toAppUser() {
    if (model == null) {
      return null;
    }
    if (model is! RecordModel) {
      return null;
    }
    final record = model as RecordModel;
    return AppUser(
      id: record.id,
      name: record.data['name'],
      verified: record.data['verified'],
      created: DateTime.tryParse(record.created),
      updated: DateTime.tryParse(record.updated),
      lastLogin: DateTime.tryParse(record.data['lastLogin'] ?? ""),
    );
  }
}

extension AuthStoreEventMappers on AuthStoreEvent {
  AppUser? toAppUser() {
    if (model == null) {
      return null;
    }
    if (model is! RecordModel) {
      return null;
    }
    final record = model as RecordModel;
    return AppUser(
      id: record.id,
      name: record.data['name'],
      verified: record.data['verified'],
      created: DateTime.tryParse(record.created),
      updated: DateTime.tryParse(record.updated),
      lastLogin: DateTime.tryParse(record.data['lastLogin'] ?? ""),
    );
  }
}
