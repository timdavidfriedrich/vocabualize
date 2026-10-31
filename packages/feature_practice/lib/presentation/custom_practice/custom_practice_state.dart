import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/entities/tag.dart';

part 'custom_practice_state.mapper.dart';

@MappableClass()
sealed class CustomPracticeState with CustomPracticeStateMappable {
  const CustomPracticeState();
}

@MappableClass()
class const CustomPracticeLoading() extends CustomPracticeState with CustomPracticeLoadingMappable;

@MappableClass()
class const CustomPracticeEditing({
  required final LanguageSetup setup,
  required final List<Tag> tags,
  required final CustomPracticeFilter filter,
  required final bool isChoosingCollections,
  required final int? count,
  required final bool hasUnfinishedSession,
  required final bool isStarting,
  required final AppError? error,
}) extends CustomPracticeState with CustomPracticeEditingMappable;

@MappableClass()
class const CustomPracticeLaunched()
    extends CustomPracticeState
    with CustomPracticeLaunchedMappable;

@MappableClass()
class const CustomPracticeFailure({
  required final AppError error,
}) extends CustomPracticeState with CustomPracticeFailureMappable;
