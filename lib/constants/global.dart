import 'package:vocabualize/constants/common_imports.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static BuildContext get context => Global.navigatorState.currentContext!;
  static GlobalKey<NavigatorState> get key => Global.navigatorState;
}
