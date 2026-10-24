import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_details/domain/use_cases/pick_image_use_case.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _defaultSourceLanguageCode = "en";
const _defaultTargetLanguageCode = "es";

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(this._vocabularyRepository, this._pickImage)
    : super(const DetailsEditing(image: null, isBusy: false, error: null)) {
    on<DetailsImagePickRequested>(_onImagePickRequested);
    on<DetailsImageRemoved>(_onImageRemoved);
    on<DetailsSaveRequested>(_onSaveRequested);
  }

  final VocabularyRepository _vocabularyRepository;
  final PickImageUseCase _pickImage;

  Future<void> _onImagePickRequested(
    DetailsImagePickRequested event,
    Emitter<DetailsState> emit,
  ) async {
    final current = state;
    if (current is! DetailsEditing || current.isBusy) return;
    final busy = current.copyWith(isBusy: true, error: null);
    emit(busy);
    final result = await _pickImage(event.source);
    emit(switch (result) {
      Success(data: final image?) => busy.copyWith(image: image, isBusy: false),
      Success(data: null) => busy.copyWith(isBusy: false),
      Failure(:final error) => busy.copyWith(isBusy: false, error: error),
    });
  }

  void _onImageRemoved(DetailsImageRemoved event, Emitter<DetailsState> emit) {
    if (state case final DetailsEditing current when !current.isBusy) {
      emit(current.copyWith(image: null, error: null));
    }
  }

  Future<void> _onSaveRequested(DetailsSaveRequested event, Emitter<DetailsState> emit) async {
    final current = state;
    if (current is! DetailsEditing || current.isBusy) return;
    final source = event.source.trim();
    final target = event.target.trim();
    if (source.isEmpty || target.isEmpty) {
      emit(current.copyWith(error: const ValidationError()));
      return;
    }
    final busy = current.copyWith(isBusy: true, error: null);
    emit(busy);
    final result = await _vocabularyRepository.addVocabulary(
      source: source,
      target: target,
      sourceLanguageCode: _defaultSourceLanguageCode,
      targetLanguageCode: _defaultTargetLanguageCode,
      image: current.image,
    );
    emit(switch (result) {
      Success() => const DetailsSaved(),
      Failure(:final error) => busy.copyWith(isBusy: false, error: error),
    });
  }
}
