import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'dart:async';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/services/pocketbase_connection.dart';

class UserStream {
  static final UserStream instance = UserStream();

  final StreamController<AppUser?> _streamController = StreamController<AppUser?>.broadcast();
  Stream<AppUser?> get stream => _streamController.stream.asBroadcastStream();

  UserStream() {
    _init();
  }

  void dispose() {
    _streamController.close();
  }

  Future<void> _init() async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    _streamController.sink.add(AppUser.fromRecord(pocketbase.authStore.model));
    _listen();
    Log.hint("User stream initialized");
  }

  void _listen() async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    pocketbase.authStore.onChange.map((event) {
      if (event.model == null) return null;
      return AppUser.fromRecord(event.model);
    }).forEach((AppUser? user) async {
      _streamController.sink.add(user);
      Log.hint("User stream: Cloud user changed to $user");
    });
  }
}
