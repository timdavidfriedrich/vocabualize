import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';

const _accessDenied = "CameraAccessDenied";
const _accessDeniedWithoutPrompt = "CameraAccessDeniedWithoutPrompt";
const _accessRestricted = "CameraAccessRestricted";

extension CameraExceptionExtensions on CameraException {
  AppError toAppError() => switch (code) {
    _accessDenied ||
    _accessDeniedWithoutPrompt ||
    _accessRestricted => const CameraPermissionError(),
    _ => const CameraUnavailableError(),
  };
}
