import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _presetPattern = "#.#";
const _precisePattern = "0.0";

extension ZoomExtensions on double {
  String toZoomPresetLabel(BuildContext context, {required bool isSelected}) {
    final value = NumberFormat(_presetPattern, _localeOf(context)).format(this);
    return isSelected ? context.s.scanZoomLabel(value) : value;
  }

  String toZoomLabel(BuildContext context) {
    return context.s.scanZoomLabel(NumberFormat(_precisePattern, _localeOf(context)).format(this));
  }

  String _localeOf(BuildContext context) => Localizations.localeOf(context).toLanguageTag();
}
