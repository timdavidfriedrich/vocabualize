import 'package:diacritic/diacritic.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _strikeThickness = 2.0;

typedef _Normalized = ({String text, List<int> mapping});

class const SolutionDiffText({
  super.key,
  required final String _givenAnswer,
  required final String _solution,
  required final int _maxLines,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = context.t.headlineSmall ?? const TextStyle();
    final correctionStyle = style.copyWith(backgroundColor: context.c.primary);
    final mistakeStyle = style.copyWith(
      backgroundColor: context.c.error,
      decoration: TextDecoration.lineThrough,
      decorationThickness: _strikeThickness,
    );
    final solution = _normalize(_solution);
    final given = _normalize(_givenAnswer);
    final differences = DiffMatchPatch().diff(given.text, solution.text);
    DiffMatchPatch().diffCleanupSemantic(differences);
    final spans = <TextSpan>[];
    var solutionPosition = 0;
    var givenPosition = 0;
    for (var index = 0; index < differences.length; index++) {
      final difference = differences[index];
      final length = difference.text.length;
      switch (difference.operation) {
        case DIFF_EQUAL:
          spans.add(TextSpan(text: _segment(solution, _solution, solutionPosition, length)));
          solutionPosition += length;
          givenPosition += length;
        case DIFF_INSERT:
          spans.add(
            TextSpan(
              text: _segment(solution, _solution, solutionPosition, length),
              style: correctionStyle,
            ),
          );
          solutionPosition += length;
        case _:
          final mistake = _segment(given, _givenAnswer, givenPosition, length);
          spans.add(TextSpan(text: " $mistake ", style: mistakeStyle));
          givenPosition += length;
          final next = differences.elementAtOrNull(index + 1);
          if (next != null && next.operation == DIFF_INSERT) {
            spans.add(
              TextSpan(
                text: _segment(solution, _solution, solutionPosition, next.text.length),
                style: correctionStyle,
              ),
            );
            solutionPosition += next.text.length;
            index++;
          }
      }
    }
    return Text.rich(
      TextSpan(style: style, children: spans),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: _maxLines,
    );
  }

  _Normalized _normalize(String text) {
    final mapping = <int>[];
    final normalized = StringBuffer();
    for (var index = 0; index < text.length; index++) {
      final character = removeDiacritics(text[index]).toLowerCase();
      for (var part = 0; part < character.length; part++) {
        mapping.add(index);
        normalized.write(character[part]);
      }
    }
    return (text: normalized.toString(), mapping: mapping);
  }

  String _segment(_Normalized normalized, String original, int position, int length) {
    if (position >= normalized.mapping.length) return "";
    final end = (position + length).clamp(0, normalized.mapping.length);
    final start = normalized.mapping[position];
    final originalEnd = (end > 0 ? normalized.mapping[end - 1] + 1 : 0).clamp(0, original.length);
    return original.substring(start, originalEnd);
  }
}
