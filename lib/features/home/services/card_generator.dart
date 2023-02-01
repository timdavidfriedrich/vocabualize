import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardGenerator {
  static String get info {
    List<Vocabulary> vocabularyList = Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList;
    List<Vocabulary> createdToday = Provider.of<VocabularyProvider>(Global.context, listen: false).createdToday;

    if (vocabularyList.isEmpty) return AppLocalizations.of(Global.context).home_statusCard_isEmpty;
    if (createdToday.length >= 3) return AppLocalizations.of(Global.context).home_statusCard_addedToday(createdToday.length);
    if (vocabularyList.length >= 10) return AppLocalizations.of(Global.context).home_statusCard_addedManyInTotal(vocabularyList.length);
    if (vocabularyList.length == 1) return AppLocalizations.of(Global.context).home_statusCard_onlyOneWord(vocabularyList.length);
    return AppLocalizations.of(Global.context).home_statusCard_default(vocabularyList.length);
  }
}
