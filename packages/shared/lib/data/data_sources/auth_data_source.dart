import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _restoreTimeout = Duration(seconds: 2);

abstract class AuthDataSource {
  Future<RemoteAccount?> restoreAccount();

  Future<RemoteAccount> signInWithGoogle();

  Future<void> signOut();
}

@Injectable(as: AuthDataSource)
class const AuthDataSourceImpl(
  final Client _client,
  final FlutterAuthSessionManager _sessionManager,
) implements AuthDataSource {
  @override
  Future<RemoteAccount?> restoreAccount() async {
    await _sessionManager.initialize(timeout: _restoreTimeout);
    return _currentAccount();
  }

  @override
  Future<RemoteAccount> signInWithGoogle() async {
    final completer = Completer<void>();
    final controller = GoogleAuthController(
      client: _client,
      onAuthenticated: () {
        if (!completer.isCompleted) completer.complete();
      },
      onError: (error) {
        if (!completer.isCompleted) completer.completeError(error);
      },
    );
    try {
      await controller.signIn();
      await completer.future;
    } finally {
      controller.dispose();
    }
    final account = await _currentAccount();
    if (account == null) throw const _SignInIncompleteException();
    return account;
  }

  @override
  Future<void> signOut() => _sessionManager.signOutDevice();

  Future<RemoteAccount?> _currentAccount() async {
    final authInfo = _sessionManager.authInfo;
    if (authInfo == null) return null;
    final id = authInfo.authUserId.toString();
    try {
      final profile = await _client.modules.serverpod_auth_core.userProfileInfo.get();
      return RemoteAccount(id: id, fullName: profile.fullName, email: profile.email);
    } on Object catch (error) {
      if (kDebugMode) debugPrint("Profile unavailable: $error");
      return RemoteAccount(id: id, fullName: null, email: null);
    }
  }
}

class const _SignInIncompleteException() implements Exception;
