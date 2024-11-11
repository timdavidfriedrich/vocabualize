import 'package:intl/intl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

extension VocabularyExtensions on Vocabulary {
  String reappearsIn() {
    DateTime now = DateTime.now();
    Duration difference = nextDate.difference(now);
    // TODO: Replace with arb
    if (difference.isNegative) return "Now";
    if (difference.inMinutes < 1) return "In less than a minutes";
    if (difference.inHours < 1) return "In ${difference.inMinutes} minutes";
    if (difference.inDays < 1) return "In ${difference.inHours} hours";
    if (difference.inDays <= 7) return "In ${difference.inDays} days";
    return DateFormat("dd.MM.yyyy - HH:mm").format(nextDate);
  }
}
