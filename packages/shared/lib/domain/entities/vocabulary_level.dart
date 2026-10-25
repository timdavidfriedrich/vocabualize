const _noviceFloor = 0.0;
const _beginnerFloor = 1.0;
const _advancedFloor = 2.0;
const _expertFloor = 3.0;

enum VocabularyLevel {
  novice(floor: _noviceFloor),
  beginner(floor: _beginnerFloor),
  advanced(floor: _advancedFloor),
  expert(floor: _expertFloor);

  const VocabularyLevel({
    required this.floor,
  });

  final double floor;
}

extension VocabularyLevelValueExtensions on double {
  VocabularyLevel toVocabularyLevel() => VocabularyLevel.values.lastWhere(
    (level) => this >= level.floor,
    orElse: () => VocabularyLevel.novice,
  );
}
