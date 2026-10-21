import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home/home_bloc.dart';
import 'package:feature_home/presentation/home/home_event.dart';
import 'package:feature_home/presentation/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/article.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const HomeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.homeTitle)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => switch (state) {
          HomeLoading() => const Center(child: CircularProgressIndicator()),
          HomeFailure(:final error) => _FailureView(error: error),
          HomeLoaded(:final articles) => _ArticleList(articles: articles),
        },
      ),
    );
  }
}

class const _ArticleList({
  required final List<Article> _articles,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty) {
      return Center(child: Text(context.s.homeEmptyMessage));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(Spacing.m),
      itemCount: _articles.length,
      separatorBuilder: (context, index) => const SizedBox(height: Spacing.xs),
      itemBuilder: (context, index) {
        final article = _articles[index];
        return ListTile(
          title: Text(article.title, style: context.t.titleMedium),
          onTap: () => context.pushArticleDetail(articleId: article.id),
        );
      },
    );
  }
}

class const _FailureView({
  required final AppError _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error.toMessage(context), textAlign: TextAlign.center),
            const SizedBox(height: Spacing.m),
            FilledButton(
              onPressed: () => context.read<HomeBloc>().add(const HomeRefreshed()),
              child: Text(context.s.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}
