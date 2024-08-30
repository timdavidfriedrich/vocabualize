import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/src/common/data/models/rdb_language.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/src/common/data/models/rdb_tag.dart';
import 'package:vocabualize/src/common/data/models/rdb_user.dart';

class RdbVocabulary {
  final String id;
  final RdbUser user;
  final String source;
  final String target;
  final RdbLanguage sourceLanguage;
  final RdbLanguage targetLanguage;
  final List<RdbTag> tags;
  final RdbVocabualaryImage? image;
  final double levelValue;
  final bool isNovice;
  final int interval;
  final double ease;
  final String nextDate;
  final String created;
  final String updated;

  const RdbVocabulary({
    this.id = "",
    this.user = const RdbUser(),
    this.source = "",
    this.target = "",
    this.sourceLanguage = const RdbLanguage(),
    this.targetLanguage = const RdbLanguage(),
    this.tags = const [],
    this.image,
    this.levelValue = 0.0,
    this.isNovice = true,
    this.interval = DueAlgorithmConstants.initialInterval,
    this.ease = DueAlgorithmConstants.initialEase,
    this.nextDate = "",
    this.created = "",
    this.updated = "",
  });
}
