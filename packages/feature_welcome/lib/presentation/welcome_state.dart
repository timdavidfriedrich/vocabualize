import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'welcome_state.mapper.dart';

@MappableClass()
sealed class WelcomeState with WelcomeStateMappable {
  const WelcomeState();
}

@MappableClass()
class const WelcomeIdle() extends WelcomeState with WelcomeIdleMappable;

@MappableClass()
class const WelcomeBusy() extends WelcomeState with WelcomeBusyMappable;

@MappableClass()
class const WelcomeFailure({
  required final AppError error,
}) extends WelcomeState with WelcomeFailureMappable;
