import 'package:diacritic/diacritic.dart';

final _nonLettersOrDigits = RegExp(r"[^\p{L}\p{N}]", unicode: true);

extension StringExtensions on String {
  String toFolded() => removeDiacritics(this).toLowerCase();

  String toComparable({required bool isStrict}) => isStrict ? toLowerCase() : toFolded();

  bool matchesLoosely(String other) =>
      toFolded().replaceAll(_nonLettersOrDigits, "") ==
      other.toFolded().replaceAll(_nonLettersOrDigits, "");
}
