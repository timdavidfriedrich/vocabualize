import 'package:async/async.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/services/auth_service.dart';
import 'package:vocabualize/features/core/services/pocketbase_connection.dart';

class UserStream {
  static final UserStream instance = UserStream();

  final AuthService _authService = AuthService.instance;

  final PocketBase _pocketbase = PocketbaseConnection.instance.pocketbase;

  final StreamController<AppUser?> _localStreamController = StreamController<AppUser?>.broadcast();
  final StreamController<AppUser?> _cloudStreamController = StreamController<AppUser?>.broadcast();
  Stream<AppUser?> get stream => _getCombinedLocalAndCloudUserStream();

  UserStream() {
    _init();
  }

  void dispose() {
    _localStreamController.close();
  }

  Future<void> _init() async {
    _sinkLocalUserToStream(await _getLocalUser());
    _listen();
    Log.hint("UserStream initialized");
  }

  void _listen() {
    var test = _pocketbase.authStore.onChange.map((event) {
      if (event.model == null) return null;
      return AppUser.fromRecord(event.model);
    });

    test.forEach(testing);
  }

  Future<void> testing(AppUser? user) async {
    Log.debug("HURENSOHN");
    final previousAuthUser = await stream.firstOrNull;
    // Log.error("previousAuthUser: $previousAuthUser");
    Log.error("user: $user");
    await _saveUserToLocalStorage(user);
    // if (previousAuthUser != null && user != null) return;
    _sinkCloudUserToStream(user);
    Log.hint("UserStream: Cloud user changed to $user");
  }

  Stream<AppUser?> _getCombinedLocalAndCloudUserStream() {
    return StreamGroup.merge([_localStreamController.stream, _cloudStreamController.stream]).asBroadcastStream();
  }

  Future<void> _saveUserToLocalStorage(AppUser? user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', user?.toRawJson() ?? "");
    Log.debug("\"userStream\" (eigentlich nicht): $user saved to local storage.");
  }

  void _sinkCloudUserToStream(AppUser? user) {
    _cloudStreamController.sink.add(user);
  }

  void _sinkLocalUserToStream(AppUser? user) {
    _localStreamController.sink.add(user);
    Log.debug("\"userStream\" (eigentlich nicht): $user loaded from local storage and sinked to user stream.");
  }

  Future<AppUser?> _getLocalUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final rawJson = sharedPreferences.getString('user');
    if (rawJson != null) {
      try {
        final json = jsonDecode(rawJson) as Map<String, dynamic>;
        return AppUser.fromJson(json);
      } catch (e) {
        Log.error(e);
        return null;
      }
    }
    return null;
  }
}
