import 'package:flutter/material.dart' as material;

extension ContextExtensions on material.BuildContext {
  Future<dynamic> showDialog(material.Widget dialog) async {
    return await material.showDialog(
      context: this,
      builder: (context) => dialog,
    );
  }
}
