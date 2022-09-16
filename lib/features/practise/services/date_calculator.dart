import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/practise/services/answer.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class DateCalculator {
  static DateTime nextDate(Vocabulary vocabulary, Answer answer) {
    int currentInterval;
    if (vocabulary.isNovice) {
      currentInterval = vocabulary.noviceInterval;
    } else {
      currentInterval = vocabulary.interval;
    }

    /// OR: (aber das muss man noch ausklügeln)
    // int currentInterval = vocabulary.isNovice ? Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval : vocabulary.interval;

    DateTime nextDate = DateTime.now();
    double easyBonus = Provider.of<SettingsProvider>(Keys.context, listen: false).easyBonus;

    switch (answer) {
      case Answer.forgot:
        vocabulary.reset();
        break;
      case Answer.hard:
        int newInterval = (currentInterval * vocabulary.ease).toInt();
        DateTime tempDate = DateTime.now().add(Duration(minutes: newInterval));
        nextDate = tempDate;
        vocabulary.interval = newInterval;
        vocabulary.ease -= 0.15;
        break;
      case Answer.good:
        int newInterval = (currentInterval * vocabulary.ease).toInt();
        DateTime tempDate = DateTime.now().add(Duration(minutes: newInterval));
        nextDate = tempDate;
        vocabulary.interval = newInterval;
        break;
      case Answer.easy:
        int newInterval = (currentInterval * vocabulary.ease * easyBonus).toInt();
        DateTime tempDate = DateTime.now().add(Duration(minutes: newInterval));
        nextDate = tempDate;
        vocabulary.interval = newInterval;
        vocabulary.ease += 0.15;
        break;
      default:
        Log.error("Answer error. Wrong difficulty.");
    }

    return nextDate;
  }
}
