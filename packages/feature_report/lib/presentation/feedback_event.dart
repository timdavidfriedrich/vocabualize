sealed class FeedbackEvent {
  const FeedbackEvent();
}

class const FeedbackSendRequested({
  required final String message,
}) extends FeedbackEvent;
