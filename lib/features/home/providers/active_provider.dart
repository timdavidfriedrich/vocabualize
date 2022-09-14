import 'package:flutter/material.dart';

class ActiveProv extends ChangeNotifier {
  bool _micIsActive = false;
  bool _typeIsActive = false;

  set micIsActive(bool status) {
    _micIsActive = status;
    notifyListeners();
  }

  set typeIsActive(bool status) {
    _typeIsActive = status;
    notifyListeners();
  }

  bool get micIsActive => _micIsActive;
  bool get typeIsActive => _typeIsActive;
}
