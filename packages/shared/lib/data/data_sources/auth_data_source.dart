import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class AuthDataSource {
  Future<RemoteAccount?> restoreAccount();

  Future<RemoteAccount?> refreshAccount();

  Future<RemoteAccount?> signInWithGoogle();

  Future<void> signOut();

  Future<void> deleteAccount();
}

@Injectable(as: AuthDataSource)
class const AuthDataSourceImpl(
  final Client _client,
  final FlutterAuthSessionManager _sessionManager,
) implements AuthDataSource {
  @override
  Future<RemoteAccount?> restoreAccount() async {
    await _sessionManager.restore();
    final authInfo = _sessionManager.authInfo;
    if (authInfo == null) return null;
    return RemoteAccount(
      id: authInfo.authUserId.toString(),
      fullName: null,
      email: null,
      pictureUrl: null,
    );
  }

  @override
  Future<RemoteAccount?> refreshAccount() async {
    final isSignedIn = await _sessionManager.validateAuthentication();
    if (!isSignedIn) return null;
    return _currentAccount();
  }

  @override
  Future<RemoteAccount?> signInWithGoogle() async {
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
      if (!completer.isCompleted) return null;
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
    final profile = await _client.modules.serverpod_auth_core.userProfileInfo.get();
    return RemoteAccount(
      id: authInfo.authUserId.toString(),
      fullName: profile.fullName,
      email: profile.email,
      pictureUrl: profile.imageUrl?.toString(),
    );
  }

  @override
  Future<void> deleteAccount() => _client.account.delete();
}

class const _SignInIncompleteException() implements Exception;
