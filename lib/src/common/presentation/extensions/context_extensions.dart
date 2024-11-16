import 'package:flutter/material.dart' as material;

extension ContextExtensions on material.BuildContext {
  Future<dynamic> showDialog(material.Widget dialog, {bool dismissible = true}) async {
    return await material.showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (context) => dialog,
    );
  }
}
