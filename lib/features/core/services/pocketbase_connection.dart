import 'package:pocketbase/pocketbase.dart';

class PocketbaseConnection {
  static PocketbaseConnection get instance {
    return PocketbaseConnection();
  }

  final PocketBase pocketbase = PocketBase('http://132.145.228.50:8090');
}
