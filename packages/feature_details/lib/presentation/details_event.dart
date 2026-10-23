sealed class DetailsEvent {
  const DetailsEvent();
}

class const DetailsSaveRequested({
  required final String source,
  required final String target,
}) extends DetailsEvent;
