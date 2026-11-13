import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension IntExtensions on int {
  String toCountLabel(BuildContext context) {
    return NumberFormat.decimalPattern(context.localeTag).format(this);
  }
}
