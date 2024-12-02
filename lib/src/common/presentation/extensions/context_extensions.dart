import 'package:flutter/material.dart' as material;

extension ContextExtensions on material.BuildContext {
  Future<dynamic> showDialog(
    material.Widget dialog, {
    bool dismissible = true,
  }) async {
    return await material.showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (context) => dialog,
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return await material.Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) async {
    return material.Navigator.pop<T?>(this, result);
  }

  void popUntilNamed(String routeName) {
    return material.Navigator.popUntil(this, material.ModalRoute.withName(routeName));
  }

  Future<Object?> popAndPushNamed(String routeName, {Object? arguments}) {
    return material.Navigator.popAndPushNamed(this, routeName, arguments: arguments);
  }
}
