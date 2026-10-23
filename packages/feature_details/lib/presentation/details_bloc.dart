import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _defaultSourceLanguageCode = "en";
const _defaultTargetLanguageCode = "es";

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(this._vocabularyRepository) : super(const DetailsEditing()) {
    on<DetailsSaveRequested>(_onSaveRequested);
  }

  final VocabularyRepository _vocabularyRepository;

  Future<void> _onSaveRequested(DetailsSaveRequested event, Emitter<DetailsState> emit) async {
    final source = event.source.trim();
    final target = event.target.trim();
    if (source.isEmpty || target.isEmpty) {
      emit(const DetailsFailure(error: ValidationError()));
      return;
    }
    emit(const DetailsSaving());
    final result = await _vocabularyRepository.addVocabulary(
      source: source,
      target: target,
      sourceLanguageCode: _defaultSourceLanguageCode,
      targetLanguageCode: _defaultTargetLanguageCode,
    );
    emit(switch (result) {
      Success() => const DetailsSaved(),
      Failure(:final error) => DetailsFailure(error: error),
    });
  }
}
