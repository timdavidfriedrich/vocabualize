// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_collections/presentation/collection_bloc.dart' as _i187;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/tag_repository.dart' as _i836;
import 'package:shared/domain/repositories/text_to_speech_repository.dart'
    as _i839;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;

class FeatureCollectionsPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i187.CollectionBloc>(() => _i187.CollectionBloc(
          gh<_i836.TagRepository>(),
          gh<_i208.VocabularyRepository>(),
          gh<_i839.TextToSpeechRepository>(),
        ));
  }
}
