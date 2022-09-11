import 'package:flutter/material.dart';

class ActiveProv extends ChangeNotifier {
  bool _micIsActive = false;
  bool typeIsActive = false;

  void setMicIsActive(bool status) {
    _micIsActive = status;
    notifyListeners();
  }

  void setTypeIsActive(bool status) {
    typeIsActive = status;
    notifyListeners();
  }

  bool getMicIsActive() => _micIsActive;
  bool getTypeIsActive() => typeIsActive;
}
