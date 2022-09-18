import 'package:flutter/material.dart';

class Keys {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static get context => Keys.navigatorState.currentContext!;
}
