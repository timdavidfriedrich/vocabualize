import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/utils/answer.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class DateCalculator {
  static DateTime nextDate(Vocabulary vocabulary, Answer answer) {
    // Vocabulary is shown for the first time => initial novice interval
    int currentInterval = vocabulary.isNovice && vocabulary.level.value == 0
        ? Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval
        : vocabulary.interval;

    DateTime nextDate = DateTime.now();
    double easyBonus = Provider.of<SettingsProvider>(Global.context, listen: false).easyBonus;
    double hardLevelFactor = (vocabulary.isNovice ? 0.5 : 1) * Provider.of<SettingsProvider>(Global.context, listen: false).hardLevelFactor;
    double goodLevelFactor = (vocabulary.isNovice ? 2 : 1) * Provider.of<SettingsProvider>(Global.context, listen: false).goodLevelFactor;
    double easyLevelFactor = (vocabulary.isNovice ? 2 : 1) * Provider.of<SettingsProvider>(Global.context, listen: false).easyLevelFactor;

    switch (answer) {
      case Answer.forgot:
        DateTime tempDate = DateTime.now().add(
          Duration(minutes: Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval),
        );
        nextDate = tempDate;
        vocabulary.reset();
        break;
      case Answer.hard:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        vocabulary.interval = (currentInterval * vocabulary.ease).toInt();
        vocabulary.ease -= 0.15;
        vocabulary.level.add(hardLevelFactor);
        break;
      case Answer.good:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        vocabulary.interval = (currentInterval * vocabulary.ease).toInt();
        vocabulary.level.add(goodLevelFactor);
        break;
      case Answer.easy:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        vocabulary.interval = (currentInterval * vocabulary.ease * easyBonus).toInt();
        vocabulary.ease += 0.15;
        vocabulary.level.add(easyLevelFactor);
        break;
      default:
        Log.error("Unknown answer type: $answer");
    }

    if (vocabulary.isNovice &&
        vocabulary.level.value >= (1 - Provider.of<SettingsProvider>(Global.context, listen: false).goodLevelFactor)) {
      vocabulary.isNovice = false;
      vocabulary.interval = Provider.of<SettingsProvider>(Global.context, listen: false).initialInterval;
    }

    return nextDate;
  }
}
