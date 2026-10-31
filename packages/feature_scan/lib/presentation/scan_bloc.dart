import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_scan/domain/repositories/image_labeling_repository.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/scan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';
import 'package:shared/domain/repositories/image_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@injectable
class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc(
    this._imageRepository,
    this._imageLabelingRepository,
    this._languageRepository,
    this._appInfoRepository,
    this._connectivityRepository,
  ) : super(const ScanCapturing(isProcessing: false, error: null)) {
    on<ScanStarted>(_onStarted);
    on<ScanConnectionRestored>(_onConnectionRestored);
    on<ScanPhotoTaken>(_onPhotoTaken);
    on<ScanRetakeRequested>(_onRetakeRequested);
    on<ScanSettingsOpened>(_onSettingsOpened);
  }

  final ImageRepository _imageRepository;
  final ImageLabelingRepository _imageLabelingRepository;
  final LanguageRepository _languageRepository;
  final AppInfoRepository _appInfoRepository;
  final ConnectivityRepository _connectivityRepository;

  Future<void> _onStarted(ScanStarted event, Emitter<ScanState> emit) {
    return emit.onEach(
      _connectivityRepository.watchIsConnected(),
      onData: (result) {
        if (result case Success(data: true)) add(const ScanConnectionRestored());
      },
    );
  }

  Future<void> _onConnectionRestored(
    ScanConnectionRestored event,
    Emitter<ScanState> emit,
  ) async {
    if (state case ScanReviewing(:final photo, suggestions: ScanSuggestionsOffline())) {
      await _suggest(photo, emit);
    }
  }

  Future<void> _onPhotoTaken(ScanPhotoTaken event, Emitter<ScanState> emit) async {
    if (state case ScanCapturing(isProcessing: true) || ScanReviewing()) {
      await _imageRepository.discardSourceImage(event.path);
      return;
    }
    emit(const ScanCapturing(isProcessing: true, error: null));
    final processed = await _imageRepository.processImage(event.path);
    await _imageRepository.discardSourceImage(event.path);
    switch (processed) {
      case Failure(:final error):
        emit(ScanCapturing(isProcessing: false, error: error));
      case Success(data: final photo):
        await _suggest(photo, emit);
    }
  }

  void _onRetakeRequested(ScanRetakeRequested event, Emitter<ScanState> emit) {
    if (state is ScanReviewing) emit(const ScanCapturing(isProcessing: false, error: null));
  }

  Future<void> _onSettingsOpened(ScanSettingsOpened event, Emitter<ScanState> emit) async {
    if (await _appInfoRepository.openAppSettings() case Failure(:final error)) {
      if (state case final ScanCapturing capturing) emit(capturing.copyWith(error: error));
    }
  }

  Future<void> _suggest(ProcessedImage photo, Emitter<ScanState> emit) async {
    if (!await _isConnected()) {
      emit(ScanReviewing(photo: photo, suggestions: const ScanSuggestionsOffline()));
      return;
    }
    emit(ScanReviewing(photo: photo, suggestions: const ScanSuggestionsLoading()));
    final suggestions = switch (await _suggestionsFor(photo)) {
      ScanSuggestionsFailed(error: ConnectionError()) when !await _isConnected() =>
        const ScanSuggestionsOffline(),
      final suggestions => suggestions,
    };
    if (state case ScanReviewing(photo: final current) when identical(current, photo)) {
      emit(ScanReviewing(photo: photo, suggestions: suggestions));
    }
  }

  Future<ScanSuggestions> _suggestionsFor(ProcessedImage photo) async {
    return switch (await _languageRepository.readLanguageSetup()) {
      Success(data: final setup?) => switch (await _imageLabelingRepository.labelImage(
        photo: photo,
        language: setup.main,
      )) {
        Success(:final data) => ScanSuggestionsLoaded(labels: data),
        Failure(:final error) => ScanSuggestionsFailed(error: error),
      },
      Success(data: null) => const ScanSuggestionsFailed(error: ValidationError()),
      Failure(:final error) => ScanSuggestionsFailed(error: error),
    };
  }

  Future<bool> _isConnected() async => switch (await _connectivityRepository.isConnected()) {
    Success(:final data) => data,
    Failure() => true,
  };
}
