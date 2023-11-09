import 'dart:async';

import 'package:pocketbase/pocketbase.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
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
  SecureSharedPref? _secureSharedPreferences;

  AuthStore get authStore => _pocketbase.authStore;
  Stream<AuthStoreEvent> get authStream => _pocketbase.authStore.onChange;

  AuthService() {
    _loadLocalAuthStore();
  }

  Future<void> _loadLocalAuthStore() async {
    _secureSharedPreferences = await SecureSharedPref.getInstance();
    AuthStore localAuthStore = AsyncAuthStore(
      save: (String data) async => _secureSharedPreferences?.putString('authStore', data, isEncrypted: true),
      initial: await _secureSharedPreferences?.getString('authStore', isEncrypted: true),
    );
    Log.hint("Loadeded AuthStore from SecureSharedPreferences: $localAuthStore");
    authStore.save(localAuthStore.token, localAuthStore.model);
  }

  Future signInAnonymously() async {
    // ? TODO: Implement signInAnonymously ?
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final RecordAuth authData = await _pocketbase.collection(_usersCollectionName).authWithPassword(email, password);
      authStore.save(authData.token, authData.record);
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
    _secureSharedPreferences = await SecureSharedPref.getInstance();
    await _secureSharedPreferences?.putString('authStore', "", isEncrypted: true);
    authStore.clear();
  }

  Future<void> _resetUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences?.setString('user', "");
  }
}
