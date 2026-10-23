import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const DetailsScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final sourceController = useTextEditingController();
    final targetController = useTextEditingController();
    return BlocListener<DetailsBloc, DetailsState>(
      listener: (context, state) => switch (state) {
        DetailsSaved() => context.closeScreen(),
        DetailsFailure(:final error) => context.showToast(error.toMessage(context)),
        DetailsEditing() || DetailsSaving() => null,
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(Spacing.xl),
          children: [
            TextField(
              controller: sourceController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: context.s.detailsSourceLabel),
            ),
            const SizedBox(height: Spacing.l),
            TextField(
              controller: targetController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: context.s.detailsTargetLabel),
            ),
            const SizedBox(height: Spacing.xl),
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) => FilledButton(
                onPressed: state is DetailsSaving
                    ? null
                    : () => context.read<DetailsBloc>().add(
                        DetailsSaveRequested(
                          source: sourceController.text,
                          target: targetController.text,
                        ),
                      ),
                child: Text(context.s.detailsSaveButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
