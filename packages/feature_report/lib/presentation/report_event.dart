sealed class ReportEvent {
  const ReportEvent();
}

class const ReportSendRequested({
  required final String message,
}) extends ReportEvent;
