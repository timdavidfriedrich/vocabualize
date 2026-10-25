import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';

extension RemoteAccountMappers on RemoteAccount {
  GoogleAccount toGoogleAccount() {
    return GoogleAccount(id: id, name: fullName, email: email);
  }

  LocalAccountMetadata toLocalAccountMetadata({
    required LocalAccountMetadata? stored,
  }) {
    return LocalAccountMetadata(
      accountId: id,
      name: fullName ?? stored?.name,
      email: email ?? stored?.email,
      hasCompletedInitialSync: stored?.hasCompletedInitialSync ?? false,
      isSignedOut: false,
    );
  }
}

extension LocalAccountMetadataMappers on LocalAccountMetadata {
  GoogleAccount toGoogleAccount() {
    return GoogleAccount(id: accountId, name: name, email: email);
  }
}
