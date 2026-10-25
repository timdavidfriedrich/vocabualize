import 'package:shared/data/models/remote_clock_state.dart';
import 'package:shared/domain/entities/clock_status.dart';

extension RemoteClockStateMappers on RemoteClockState {
  ClockStatus toClockStatus() => switch (this) {
    RemoteClockState.unknown => ClockStatus.unknown,
    RemoteClockState.correct => ClockStatus.correct,
    RemoteClockState.wrong => ClockStatus.wrong,
  };
}
