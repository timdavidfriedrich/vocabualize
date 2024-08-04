import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';

class AuthenticationDataSource {
  static final AuthenticationDataSource instance = AuthenticationDataSource();

  final String _usersCollectionName = "users";

  final StreamController<AppUser?> _userStreamController = StreamController<AppUser?>.broadcast();
  Stream<AppUser?> get stream => _userStreamController.stream.asBroadcastStream();

  AuthenticationDataSource() {
    _initUserStream();
  }

  // TODO: Is this still in use? If not, should this be used?
  void dispose() {
    _userStreamController.close();
  }

  Future<void> _initUserStream() async {
    final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    _userStreamController.sink.add(AppUser.fromRecord(pocketbase.authStore.model));
    _listenToUserChanges();
    Log.hint("User stream initialized");
  }

  void _listenToUserChanges() async {
    final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    pocketbase.authStore.onChange.map((event) {
      if (event.model == null) return null;
      return AppUser.fromRecord(event.model);
    }).forEach((AppUser? user) async {
      _userStreamController.sink.add(user);
      Log.hint("User stream: Cloud user changed to $user");
    });
  }

  Future signInAnonymously() async {
    // ? TODO: Implement signInAnonymously ?
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await RemoteDatabaseDataSource.getConnection();
      final RecordAuth authData = await pocketbase.collection(_usersCollectionName).authWithPassword(email, password);
      pocketbase.authStore.save(authData.token, authData.record);
      Log.hint("Signed in with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      HelperWidgets.showStaticDialog(AlertDialog.adaptive(content: Text(e.toString())));
      Log.error("Failed to sign in with passwort.", exception: e);
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await RemoteDatabaseDataSource.getConnection();
      final RecordModel authData = await pocketbase.collection(_usersCollectionName).create(body: {
        "email": email,
        "password": password,
      });
      Log.hint("Created user with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      HelperWidgets.showStaticDialog(AlertDialog.adaptive(content: Text(e.toString())));
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
    final pocketbase = await RemoteDatabaseDataSource.getConnection();
    await secureStorage.write(key: 'authStore', value: "");
    pocketbase.authStore.clear();
  }
}
