import 'package:feature_home/presentation/article_detail/article_detail_bloc.dart';
import 'package:feature_home/presentation/article_detail/article_detail_event.dart';
import 'package:feature_home/presentation/article_detail/article_detail_screen.dart';
import 'package:feature_home/presentation/home/home_bloc.dart';
import 'package:feature_home/presentation/home/home_event.dart';
import 'package:feature_home/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/presentation/navigation/routes.dart';

import 'package:vocabualize/src/di/service_locator.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

@singleton
class NavigationRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoute.home.path,
    redirect: (context, state) => state.uri.path == "/" ? NavigationRoute.home.path : null,
    routes: [
      GoRoute(
        path: NavigationRoute.home.path,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
          child: const HomeScreen(),
        ),
        routes: [
          GoRoute(
            path: ":$parameterId",
            builder: (context, state) => BlocProvider(
              create: (_) =>
                  sl<ArticleDetailBloc>(param1: state.pathParameters[parameterId])
                    ..add(const ArticleDetailStarted()),
              child: const ArticleDetailScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
