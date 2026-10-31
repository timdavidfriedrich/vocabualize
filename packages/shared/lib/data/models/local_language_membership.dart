import 'package:vocabualize_client/vocabualize_client.dart';

class const LocalLanguageMembership({
  required final Set<UuidValue> vocabularyIds,
  required final Set<UuidValue> inLanguage,
  required final List<LocalVocabularyTag> tagLinks,
  required final List<LocalTag> tags,
});
