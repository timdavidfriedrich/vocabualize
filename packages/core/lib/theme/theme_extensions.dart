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
