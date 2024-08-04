import 'dart:math';

import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/src/common/presentation/providers/vocabulary_provider.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardGenerator {
  static bool _hasBeenCreatedToday(Vocabulary vocabulary) {
    DateTime todayRaw = DateTime.now();
    DateTime today = DateTime(todayRaw.year, todayRaw.month, todayRaw.day);
    DateTime creationDayRaw = vocabulary.created;
    DateTime creationDay = DateTime(creationDayRaw.year, creationDayRaw.month, creationDayRaw.day);
    if (creationDay.isAtSameMomentAs(today)) return true;
    return false;
  }

  static String get info {
    List<Vocabulary> vocabularyList = Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList;
    List<Vocabulary> createdToday = Provider.of<VocabularyProvider>(Global.context, listen: false).createdToday;

    List<String> possibleInfos = [];

    if (vocabularyList.length == 1 && _hasBeenCreatedToday(vocabularyList.first)) {
      return AppLocalizations.of(Global.context)?.home_statusCard_firstWord ?? "";
    }
    if (vocabularyList.isEmpty) {
      possibleInfos.add(AppLocalizations.of(Global.context)?.home_statusCard_isEmpty ?? "");
    }
    if (createdToday.length >= 3) {
      possibleInfos.add(AppLocalizations.of(Global.context)?.home_statusCard_addedToday(createdToday.length) ?? "");
    }
    if (vocabularyList.length >= 10) {
      possibleInfos.add(AppLocalizations.of(Global.context)?.home_statusCard_addedManyInTotal(vocabularyList.length) ?? "");
    }
    if (vocabularyList.length == 1) {
      possibleInfos.add(AppLocalizations.of(Global.context)?.home_statusCard_onlyOneWord(vocabularyList.length) ?? "");
    }
    possibleInfos.add(AppLocalizations.of(Global.context)?.home_statusCard_default(vocabularyList.length) ?? "");

    return possibleInfos.elementAt(Random().nextInt(possibleInfos.length));
  }
}
