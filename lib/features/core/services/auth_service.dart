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

  final PocketBase _pocketbase = PocketbaseConnection.instance.pocketbase;
  final String _usersCollectionName = "users";

  SharedPreferences? _sharedPreferences;
  FlutterSecureStorage? _secureStorage;

  AuthService() {
    _loadLocalAuthStore();
  }

  Future<void> _loadLocalAuthStore() async {
    _secureStorage = const FlutterSecureStorage();
    AuthStore localAuthStore = AsyncAuthStore(
      save: (String data) async => _secureStorage?.write(key: 'authStore', value: data),
      initial: await _secureStorage?.read(key: 'authStore'),
    );
    Log.hint("Loadeded AuthStore from SecureSharedPreferences: ${localAuthStore.model}");
    if (localAuthStore.model != null) {
      _pocketbase.authStore.save(localAuthStore.token, localAuthStore.model);
    }
  }

  Future signInAnonymously() async {
    // ? TODO: Implement signInAnonymously ?
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final RecordAuth authData = await _pocketbase.collection(_usersCollectionName).authWithPassword(email, password);
      _pocketbase.authStore.save(authData.token, authData.record);
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
      final RecordModel authData = await _pocketbase.collection(_usersCollectionName).create(body: {
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
    _secureStorage = const FlutterSecureStorage();
    await _secureStorage?.write(key: 'authStore', value: "");
    _pocketbase.authStore.clear();
  }

  Future<void> _resetUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences?.setString('user', "");
  }
}
