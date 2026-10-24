import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@injectable
class LanguagePairCubit extends Cubit<LanguagePair?> {
  LanguagePairCubit(this._settingsRepository) : super(null);

  final SettingsRepository _settingsRepository;
  StreamSubscription<AppResult<LanguagePair?>>? _subscription;

  void start() {
    _subscription ??= _settingsRepository.watchLanguagePair().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
