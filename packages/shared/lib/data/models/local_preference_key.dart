enum LocalPreferenceKey {
  typeAnswerDisabled("typeAnswerDisabled"),
  strictCorrectionEnabled("strictCorrectionEnabled"),
  imagesHidden("imagesHidden"),
  appearanceMode("appearanceMode"),
  defaultGatherOption("defaultGatherOption"),
  practiceReminder("practiceReminder"),
  streakReminder("streakReminder");

  const LocalPreferenceKey(this.value);

  final String value;
}
