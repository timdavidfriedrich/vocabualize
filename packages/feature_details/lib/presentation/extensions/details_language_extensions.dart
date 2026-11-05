import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

extension DetailsLanguageExtensions on Language {
  String toRoleLabel(BuildContext context, DetailsEditing editing) {
    if (this == editing.setup.main) {
      return context.s.detailsLanguageRoleLabel(
        toShortLabel(context),
        context.s.languagesSpeakTitle,
      );
    }
    return toLabel(context);
  }
}
