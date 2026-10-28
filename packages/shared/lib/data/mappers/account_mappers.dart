import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';

extension RemoteAccountMappers on RemoteAccount {
  GoogleAccount toGoogleAccount() {
    return GoogleAccount(id: id, name: fullName, email: email, picturePath: null);
  }

  LocalAccountMetadata toLocalAccountMetadata({
    required LocalAccountMetadata? stored,
  }) {
    return LocalAccountMetadata(
      accountId: id,
      name: fullName ?? stored?.name,
      email: email ?? stored?.email,
      pictureUrl: stored?.pictureUrl,
      pictureFileName: stored?.pictureFileName,
      hasCompletedInitialSync: stored?.hasCompletedInitialSync ?? false,
    );
  }
}

extension LocalAccountMetadataMappers on LocalAccountMetadata {
  GoogleAccount toGoogleAccount({required String? picturePath}) {
    return GoogleAccount(id: accountId, name: name, email: email, picturePath: picturePath);
  }
}
