import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/common_constants.dart';

class PocketbaseConnection {
  static PocketbaseConnection get instance {
    return PocketbaseConnection();
  }

  final PocketBase pocketbase = PocketBase(CommonConstants.pocketbaseUrl);
}
