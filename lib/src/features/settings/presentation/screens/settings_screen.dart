import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:vocabualize/src/features/settings/presentation/states/settings_state.dart';

class SettingsScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/Settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = settingsControllerProvider;
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    final strings = AppLocalizations.of(context);

    return asyncState.when(
      loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      error: (error, stackTrace) {
        // TODO: Replace with error widget
        return Center(child: Text(error.toString()));
      },
      data: (SettingsState state) {
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.largeSpacing),
              topRight: Radius.circular(Dimensions.largeSpacing),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  strings?.settings_title ?? "",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.largeSpacing,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: Dimensions.mediumSpacing),
                    _ProfileContainer(state: state, notifier: notifier),
                    const SizedBox(height: Dimensions.mediumSpacing),
                    _SettingsListTile(
                      title: strings?.settings_source ?? "",
                      subtitle: strings?.settings_sourceHint ?? "",
                      trailing: OutlinedButton(
                        onPressed: () async {
                          ref.read(notifier).selectSourceLanguage(context);
                        },
                        child: Text(state.sourceLanguage.name),
                      ),
                    ),
                    _SettingsListTile(
                      title: strings?.settings_target ?? "",
                      subtitle: strings?.settings_targetHint ?? "",
                      trailing: OutlinedButton(
                        onPressed: () {
                          ref.read(notifier).selectTargetLanguage(context);
                        },
                        child: Text(state.targetLanguage.name),
                      ),
                    ),
                    _SettingsListTile(
                      title: strings?.settings_images ?? "",
                      subtitle: strings?.settings_imagesHint ?? "",
                      trailing: Switch(
                        value: state.areImagesEnabled,
                        onChanged: ref.read(notifier).setAreImagesEnabled,
                      ),
                    ),
                    _SettingsListTile(
                      // TODO: Replace with arb
                      title: "Use DeepL translator",
                      // TODO: Replace with arb
                      subtitle: "Likely to increase translation quality.",
                      trailing: Switch(
                        value: state.usePremiumTranslator,
                        onChanged: ref.read(notifier).setUsePremiumTranslator,
                      ),
                    ),
                    _SettingsListTile(
                      // TODO: Replace with arb
                      title: "Gather notification",
                      // TODO: Replace with arb
                      subtitle: "Time to be reminded to gather words.",
                      trailing: OutlinedButton(
                        onPressed: () => ref
                            .read(notifier)
                            .selectGatherNotificationTime(context),
                        child: Text(
                          "${state.gatherNotificationTime.hour.toString().padLeft(2, '0')}:"
                          "${state.gatherNotificationTime.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    ),
                    _SettingsListTile(
                      // TODO: Replace with arb
                      title: "Practise notification",
                      // TODO: Replace with arb
                      subtitle: "Time to be reminded to practise.",
                      trailing: OutlinedButton(
                        onPressed: () => ref
                            .read(notifier)
                            .selectPractiseNotificationTime(context),
                        child: Text(
                          "${state.practiseNotificationTime.hour.toString().padLeft(2, '0')}:"
                          "${state.practiseNotificationTime.minute.toString().padLeft(2, '0')}",
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.extraLargeSpacing),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileContainer extends ConsumerWidget {
  final SettingsState state;
  final Refreshable<SettingsController> notifier;
  const _ProfileContainer({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.mediumSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (state.currentUser != null) ...[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: state.currentUser?.avatarUrl?.let((url) {
                return CachedNetworkImageProvider(url);
              }),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onPrimary,
              ).takeIf((_) => state.currentUser?.avatarUrl == null),
            ),
            const SizedBox(width: Dimensions.mediumSpacing),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.currentUser != null) ...[
                  Text(state.currentUser?.displayName ?? ""),
                  const SizedBox(height: Dimensions.extraSmallSpacing),
                  Text(
                    state.currentUser?.info ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ] else ...[
                  const Text(
                    // TODO: Replace with arb
                    "Sign in to sync your data across devices.",
                  ),
                  const SizedBox(height: Dimensions.smallSpacing),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () => ref.read(notifier).signIn(context),
                      // TODO: Replace with arb
                      child: const Text("Sign in"),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (state.currentUser != null) ...[
            const SizedBox(width: Dimensions.smallSpacing),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(notifier).signOut(context);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsListTile({
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(title),
      subtitle: subtitle?.let((text) {
        return Text(
          text,
          style: TextStyle(color: Theme.of(context).hintColor),
        );
      }),
      trailing: trailing,
    );
  }
}
