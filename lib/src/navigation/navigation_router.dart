import 'package:feature_home/presentation/article_detail/article_detail_bloc.dart';
import 'package:feature_home/presentation/article_detail/article_detail_event.dart';
import 'package:feature_home/presentation/article_detail/article_detail_screen.dart';
import 'package:feature_home/presentation/home/home_bloc.dart';
import 'package:feature_home/presentation/home/home_event.dart';
import 'package:feature_home/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:vocabualize/src/di/service_locator.dart';

@lazySingleton
class NavigationRouter() {
  late final KaiselRouterConfig<AppRoute> config = KaiselRouterConfig<AppRoute>(
    initial: const Home(),
    builder: (context, route) => _AppPage(route: route),
  );
}

class const _AppPage({
  required final AppRoute _route,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (_route) {
    Home() => BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: const HomeScreen(),
    ),
    ArticleDetail(:final articleId) => BlocProvider(
      create: (_) => sl<ArticleDetailBloc>(param1: articleId)..add(const ArticleDetailStarted()),
      child: const ArticleDetailScreen(),
    ),
  };
}
