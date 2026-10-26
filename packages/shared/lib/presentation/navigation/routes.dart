import 'package:kaisel/kaisel.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/processed_image.dart';

sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

class const Loading() extends AppRoute;

class const WaitForData({
  required final DataUnavailableReason reason,
}) extends AppRoute;

class const Welcome() extends AppRoute;

class const LanguageSelection({
  required final bool isOnboarding,
}) extends AppRoute;

class const Home() extends AppRoute;

class const NewVocabularyDetails({
  required final String source,
  final ProcessedImage? photo,
}) extends AppRoute {
  @override
  List<Object?> get props => [source, photo];
}

class const Scan() extends AppRoute;

class const EditVocabularyDetails({
  required final String vocabularyId,
}) extends AppRoute {
  @override
  List<Object?> get props => [vocabularyId];
}

class const Practice({
  final String? tagId,
}) extends AppRoute {
  @override
  List<Object?> get props => [tagId];
}

class const Collection({
  required final String tagId,
}) extends AppRoute {
  @override
  List<Object?> get props => [tagId];
}

class const Settings() extends AppRoute;
