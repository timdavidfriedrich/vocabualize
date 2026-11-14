import 'dart:async';

import 'package:shared/data/models/local_custom_practice.dart';

abstract class CustomPracticeLocalDataSource {
  Stream<LocalCustomPractice?> watchCustomPractice();

  Future<LocalCustomPractice?> readCustomPractice();

  Future<void> saveCustomPractice(LocalCustomPractice practice);

  Future<void> deleteCustomPractice();
}
