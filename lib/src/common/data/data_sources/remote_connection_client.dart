import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/secrets/pocketbase_secrets.dart';

final remoteConnectionClientProvider = Provider((ref) => RemoteConnectionClient());

class RemoteConnectionClient {
  final String _authStoreKey = "authStore";
  PocketBase? _pocketBase;

  Future<PocketBase> getConnection() async {
    FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
    if (_pocketBase == null) {
      Log.debug("Current authStore: ${await secureStorage.read(key: _authStoreKey)}");
      return _pocketBase = PocketBase(
        PocketbaseSecrets.databaseUrl,
        authStore: AsyncAuthStore(
          save: (String data) async {
            Log.debug("Saving authStore: $data");
            return secureStorage.write(key: _authStoreKey, value: data);
          },
          initial: await secureStorage.read(key: _authStoreKey),
        ),
      );
    } else {
      return _pocketBase!;
    }
  }
}
