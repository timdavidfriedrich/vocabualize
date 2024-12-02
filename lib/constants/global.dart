import 'package:flutter/widgets.dart';

// TODO: Remove Global class, after Provider package has been removed
class Global {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static BuildContext get context => Global.navigatorState.currentContext!;
}
