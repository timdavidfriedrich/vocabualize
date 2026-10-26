import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@injectable
class PreferencesCubit extends Cubit<Preferences> {
  PreferencesCubit(this._settingsRepository) : super(defaultPreferences);

  final SettingsRepository _settingsRepository;
  StreamSubscription<AppResult<Preferences>>? _subscription;

  void start() {
    _subscription ??= _settingsRepository.watchPreferences().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
