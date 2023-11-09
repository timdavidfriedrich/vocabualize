import 'package:async/async.dart';
import 'package:log/log.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/services/auth_service.dart';

class UserStream {
  static final UserStream instance = UserStream();

  final AuthService _authService = AuthService.instance;

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
    _authService.authStream.map((event) {
      if (event.model == null) return null;
      return AppUser.fromRecord(event.model);
    }).listen((user) {
      _saveUserToLocalStorage(user);
      _sinkCloudUserToStream(user);
      Log.hint("UserStream: Cloud user changed to $user");
    });
  }

  Stream<AppUser?> _getCombinedLocalAndCloudUserStream() {
    return StreamGroup.merge([_localStreamController.stream, _cloudStreamController.stream]);
  }

  Future<void> _saveUserToLocalStorage(user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user', user?.toRawJson() ?? "");
  }

  void _sinkCloudUserToStream(user) {
    _cloudStreamController.sink.add(user);
  }

  void _sinkLocalUserToStream(user) {
    _localStreamController.sink.add(user);
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
