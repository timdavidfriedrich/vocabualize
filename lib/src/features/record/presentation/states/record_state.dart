enum ActiveMethod {
  type,
  mic,
  none,
}

class RecordState {
  final ActiveMethod activeMethod;

  const RecordState({
    this.activeMethod = ActiveMethod.none,
  });

  RecordState copyWith({
    ActiveMethod? activeMethod,
  }) {
    return RecordState(
      activeMethod: activeMethod ?? this.activeMethod,
    );
  }
}
