enum LocalPreferenceKey {
  typeAnswerDisabled("typeAnswerDisabled"),
  imagesHidden("imagesHidden"),
  practiceReminder("practiceReminder"),
  streakReminder("streakReminder");

  const LocalPreferenceKey(this.value);

  final String value;
}
