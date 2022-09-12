import 'package:flutter/material.dart';

class Keys {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static get context => Keys.navigatorState.currentContext!;
}
