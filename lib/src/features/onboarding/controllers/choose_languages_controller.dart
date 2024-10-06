import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/set_source_language_use_case.dart';
import 'package:vocabualize/src/common/presentation/screens/language_picker_screen.dart';
import 'package:vocabualize/src/features/onboarding/states/choose_languages_state.dart';

final chooseLanguagesControllerProvider = AutoDisposeAsyncNotifierProvider<ChooseLanguagesController, ChooseLanguagesState>(() {
  return ChooseLanguagesController();
});

class ChooseLanguagesController extends AutoDisposeAsyncNotifier<ChooseLanguagesState> {
  @override
  FutureOr<ChooseLanguagesState> build() {
    return ChooseLanguagesState(
      selectedSourceLanguage: Language.defaultSource(),
      selectedTargetLanguage: Language.defaultTarget(),
    );
  }

  Future<void> openPickerAndSelectSourceLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    if (seletectedLanguage != null) {
      state = const AsyncLoading();
      await ref.read(setSourceLanguageUseCaseProvider(seletectedLanguage));
    }
  }

  Future<void> openPickerAndSelectTargetLanguage(BuildContext context) async {
    final seletectedLanguage = await Navigator.pushNamed(context, LanguagePickerScreen.routeName) as Language?;
    if (seletectedLanguage != null) {
      state = const AsyncLoading();
      await ref.read(setTargetLanguageUseCaseProvider(seletectedLanguage));
    }
  }

  void close(BuildContext context) {
    Navigator.pop(context);
  }
}
