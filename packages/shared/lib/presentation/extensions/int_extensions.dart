import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension IntExtensions on int {
  String toCountLabel(BuildContext context) {
    return NumberFormat.decimalPattern(Localizations.localeOf(context).toLanguageTag())
        .format(this);
  }
}
