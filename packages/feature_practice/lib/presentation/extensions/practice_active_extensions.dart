import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:shared/domain/entities/practice_card.dart';

extension PracticeActiveExtensions on PracticeActive {
  PracticeCard get current => queue.first;
}
