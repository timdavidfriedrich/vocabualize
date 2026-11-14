import 'dart:async';

import 'package:shared/data/models/remote_account.dart';

abstract class AuthDataSource {
  Future<RemoteAccount?> restoreAccount();

  Future<RemoteAccount?> refreshAccount();

  Future<RemoteAccount?> signInWithGoogle();

  Future<void> signOut();

  Future<void> deleteAccount();
}
