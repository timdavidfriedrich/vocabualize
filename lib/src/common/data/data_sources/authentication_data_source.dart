import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_connection_client.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

final authenticationDataSourceProvider = Provider((ref) {
  return AuthenticationDataSource(
    connectionClient: ref.watch(remoteConnectionClientProvider),
  );
});

class AuthenticationDataSource {
  final RemoteConnectionClient _connectionClient;
  final String _usersCollectionName = "users";

  const AuthenticationDataSource({
    required RemoteConnectionClient connectionClient,
  }) : _connectionClient = connectionClient;

  Future signInAnonymously() async {
    // ? TODO: Implement signInAnonymously ?
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await _connectionClient.getConnection();
      final RecordAuth authData = await pocketbase.collection(_usersCollectionName).authWithPassword(email, password);
      pocketbase.authStore.save(authData.token, authData.record);
      Log.hint("Signed in with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      if (Global.context.mounted) {
        await Global.context.showDialog(AlertDialog.adaptive(content: Text(e.toString())));
      }
      Log.error("Failed to sign in with passwort.", exception: e);
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await _connectionClient.getConnection();
      final RecordModel authData = await pocketbase.collection(_usersCollectionName).create(body: {
        "email": email,
        "password": password,
      });
      Log.hint("Created user with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      if (Global.context.mounted) {
        await Global.context.showDialog(AlertDialog.adaptive(content: Text(e.toString())));
      }
      Log.error("Failed to create user with email and password.", exception: e);
      return false;
    }
  }

  Future sendVerificationEmail() async {
    // TODO: Implement sendVerificationEmail
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // TODO: Implement sendPasswordResetEmail
  }

  Future<bool> signOut() async {
    try {
      await _resetAuthStore();
      return true;
    } catch (e) {
      Log.error("Failed to sign out.", exception: e);
      return false;
    }
  }

  Future<void> _resetAuthStore() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final pocketbase = await _connectionClient.getConnection();
    await secureStorage.write(key: 'authStore', value: "");
    pocketbase.authStore.clear();
  }
}
