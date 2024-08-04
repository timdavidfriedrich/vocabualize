import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/secrets/pocketbase_secrets.dart';

class PocketbaseConnection {
  static PocketBase? _pocketBase;
  static Future<PocketBase> connect() async {
    FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
    if (_pocketBase == null) {
      return _pocketBase = PocketBase(
        PocketbaseSecrets.databaseUrl,
        authStore: AsyncAuthStore(
          save: (String data) async => secureStorage.write(key: 'authStore', value: data),
          initial: await secureStorage.read(key: 'authStore'),
        ),
      );
    } else {
      return _pocketBase!;
    }
  }

  static void saveAuth(String newToken, dynamic model) async {
    if (_pocketBase == null) {
      await connect();
    }
    _pocketBase?.authStore.save(newToken, model);
  }
}
