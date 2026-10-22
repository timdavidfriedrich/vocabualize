import 'package:flutter/material.dart';

class const StatusColors({
  required final Color success,
  required final Color warning,
}) extends ThemeExtension<StatusColors> {
  @override
  StatusColors copyWith({Color? success, Color? warning}) {
    return StatusColors(success: success ?? this.success, warning: warning ?? this.warning);
  }

  @override
  StatusColors lerp(StatusColors? other, double t) {
    if (other == null) return this;
    return StatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

class const LevelColors({
  required final Color novice,
  required final Color beginner,
  required final Color advanced,
  required final Color expert,
}) extends ThemeExtension<LevelColors> {
  @override
  LevelColors copyWith({Color? novice, Color? beginner, Color? advanced, Color? expert}) {
    return LevelColors(
      novice: novice ?? this.novice,
      beginner: beginner ?? this.beginner,
      advanced: advanced ?? this.advanced,
      expert: expert ?? this.expert,
    );
  }

  @override
  LevelColors lerp(LevelColors? other, double t) {
    if (other == null) return this;
    return LevelColors(
      novice: Color.lerp(novice, other.novice, t)!,
      beginner: Color.lerp(beginner, other.beginner, t)!,
      advanced: Color.lerp(advanced, other.advanced, t)!,
      expert: Color.lerp(expert, other.expert, t)!,
    );
  }
}
