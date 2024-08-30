class DueAlgorithmConstants {
  DueAlgorithmConstants._();

  static const int initialInterval = 1440; // minutes (1 day)
  static const int initialNoviceInterval = 1; // minutes
  static const double initialEase = 2.5;
  // TODO: Research, if the ease downgrade/update values are correct
  static const double easeDowngrade = 0.15; // 0.2; this was the original value, but somehow I always used 0.15
  static const double easyUpgrade = 0.15; // 1.3; this was the original value, but somehow I always used 0.15
  static const double easyLevelFactor = 0.6;
  static const double goodLevelFactor = 0.3;
  static const double hardLevelFactor = -0.3;
  static const double levelLimit = 3.0;
}
