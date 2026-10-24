import 'package:kaisel/kaisel.dart';

sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

class const Splash() extends AppRoute;

class const Welcome() extends AppRoute;

class const LanguageSelection({
  required final bool isOnboarding,
}) extends AppRoute;

class const Home() extends AppRoute;

class const VocabularyDetails() extends AppRoute;

class const Settings() extends AppRoute;
