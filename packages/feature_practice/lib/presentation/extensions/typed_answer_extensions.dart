import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:shared/domain/entities/practice_answer.dart';

const _apostrophe = "'";
const _goodMistakeLimit = 2;

extension TypedAnswerExtensions on String {
  PracticeAnswer gradeAgainst(String solution, {required Set<String> articles}) {
    final article = leadingArticle(articles) ?? "";
    if (substring(article.length).trim().isEmpty) return PracticeAnswer.forgot;
    final differences = diff(
      removeDiacritics(this).toLowerCase(),
      removeDiacritics(solution).toLowerCase(),
    );
    return switch (_mistakes(differences)) {
      0 => PracticeAnswer.easy,
      <= _goodMistakeLimit => PracticeAnswer.good,
      _ => PracticeAnswer.hard,
    };
  }

  String? leadingArticle(Set<String> articles) {
    for (final article in articles) {
      if (article.endsWith(_apostrophe) && startsWith(article)) return article;
      if (startsWith("$article ")) return "$article ";
    }
    return null;
  }

  // * a run of deletions and insertions between two equal parts is one replacement, so it
  // * counts as the longer of both, not as their sum
  int _mistakes(List<Diff> differences) {
    var mistakes = 0;
    var deleted = 0;
    var inserted = 0;
    for (final difference in differences) {
      switch (difference.operation) {
        case DIFF_DELETE:
          deleted += difference.text.length;
        case DIFF_INSERT:
          inserted += difference.text.length;
        case _:
          mistakes += max(deleted, inserted);
          deleted = 0;
          inserted = 0;
      }
    }
    return mistakes + max(deleted, inserted);
  }
}
