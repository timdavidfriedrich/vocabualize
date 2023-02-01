import 'package:vocabualize/constants/common_imports.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static get context => Global.navigatorState.currentContext!;
  static get key => Global.navigatorState;
}
