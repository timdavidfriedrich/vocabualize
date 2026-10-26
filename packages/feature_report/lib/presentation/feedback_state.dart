import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'feedback_state.mapper.dart';

@MappableClass()
sealed class FeedbackState with FeedbackStateMappable {
  const FeedbackState();
}

@MappableClass()
class const FeedbackEditing({
  required final bool isSending,
  required final AppError? error,
}) extends FeedbackState with FeedbackEditingMappable;

@MappableClass()
class const FeedbackSent() extends FeedbackState with FeedbackSentMappable;
