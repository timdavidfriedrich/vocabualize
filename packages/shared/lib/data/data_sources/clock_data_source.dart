import 'dart:async';

import 'package:shared/data/models/remote_clock_state.dart';

class const ClockWrongException() implements Exception;

abstract class ClockDataSource {
  Stream<RemoteClockState> watchState();

  Future<RemoteClockState> checkWithServer();

  bool isWriteBlocked();
}
