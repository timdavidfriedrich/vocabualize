import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class PexelsButton extends StatelessWidget {
  const PexelsButton({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  Future<void> _openInBrowser() async {
    if (!await launchUrl(Uri.parse(vocabulary.pexelsModel.url), mode: LaunchMode.externalApplication)) return;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _openInBrowser(),
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        // TODO: Replace with arb
        "Photo by ${vocabulary.pexelsModel.photographer} on Pexels",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
      ),
    );
  }
}
