import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:vocabualize/features/core/services/messaging_service.dart';
import 'package:vocabualize/features/core/services/pocketbase_connection.dart';

class AuthService {
  static final AuthService instance = AuthService();

  final String _usersCollectionName = "users";

  SharedPreferences? _sharedPreferences;

  Future signInAnonymously() async {
    // ? TODO: Implement signInAnonymously ?
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await PocketbaseConnection.connect();
      final RecordAuth authData = await pocketbase.collection(_usersCollectionName).authWithPassword(email, password);
      pocketbase.authStore.save(authData.token, authData.record);
      Log.hint("Signed in with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      MessangingService.showStaticDialog(AlertDialog.adaptive(content: Text(e.toString())));
      Log.error("Could not sign in with passwort: $e");
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final pocketbase = await PocketbaseConnection.connect();
      final RecordModel authData = await pocketbase.collection(_usersCollectionName).create(body: {
        "email": email,
        "password": password,
      });
      Log.hint("Created user with email and password (AuthData: $authData)");
      return true;
    } catch (e) {
      MessangingService.showStaticDialog(AlertDialog.adaptive(content: Text(e.toString())));
      Log.error("Could not create user with email and password: $e");
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
      await _resetUserData();
      await _resetAuthStore();
      return true;
    } catch (e) {
      Log.error("Could not sign out: $e");
      return false;
    }
  }

  Future<void> _resetAuthStore() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final pocketbase = await PocketbaseConnection.connect();
    await secureStorage.write(key: 'authStore', value: "");
    pocketbase.authStore.clear();
  }

  Future<void> _resetUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences?.setString('user', "");
  }
}
