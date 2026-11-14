import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_info_dialog.dart';

extension HomeContextExtensions on BuildContext {
  void showVocabularyInfo(Vocabulary vocabulary) {
    final bloc = read<HomeBloc>();
    if (bloc.state case HomeLoaded(:final setup, :final collections)) {
      showVocabularyInfoDialog(
        this,
        vocabulary: vocabulary,
        language: setup.selected,
        mainLanguage: setup.main,
        tags: [for (final collection in collections) collection.tag],
        onSpeak: () => bloc.add(HomeVocabularySpeakRequested(vocabulary: vocabulary)),
        onEdit: () => pushEditVocabularyDetails(vocabularyId: vocabulary.id),
        onPhotographerOpened: (url) => bloc.add(HomePhotographerLinkOpened(url: url)),
      );
    }
  }

  void speakVocabulary(Vocabulary vocabulary) {
    read<HomeBloc>().add(HomeVocabularySpeakRequested(vocabulary: vocabulary));
  }
}
