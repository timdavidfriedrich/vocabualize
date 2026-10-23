import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';

extension RemoteAccountMappers on RemoteAccount {
  GoogleAccount toGoogleAccount() {
    return GoogleAccount(id: id, name: fullName, email: email);
  }
}
