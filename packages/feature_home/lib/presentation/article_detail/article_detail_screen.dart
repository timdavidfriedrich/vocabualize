import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/article_detail/article_detail_bloc.dart';
import 'package:feature_home/presentation/article_detail/article_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/article.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const ArticleDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        builder: (context, state) => switch (state) {
          ArticleDetailLoading() => const Center(child: CircularProgressIndicator()),
          ArticleDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          ArticleDetailLoaded(:final article) => _Content(article: article),
        },
      ),
    );
  }
}

class const _Content({
  required final Article _article,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_article.title, style: context.t.headlineSmall),
          const SizedBox(height: Spacing.s),
          Text(
            _article.status.name,
            style: context.t.labelLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
