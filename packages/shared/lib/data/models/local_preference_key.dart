enum LocalPreferenceKey {
  typeAnswerDisabled("typeAnswerDisabled"),
  imagesHidden("imagesHidden"),
  appearanceMode("appearanceMode"),
  practiceReminder("practiceReminder"),
  streakReminder("streakReminder");

  const LocalPreferenceKey(this.value);

  final String value;
}
