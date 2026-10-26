import 'package:serverpod/serverpod.dart';

import '../adapters/translation/translation_provider.dart';
import '../generated/protocol.dart';
import 'caller.dart';
import 'config_source.dart';
import 'metered_call.dart';
import 'usage_quota.dart';

const _invalidRequest = "invalidRequest";

class const TranslationService(
  final TranslationProvider Function() _provider,
) {
  Future<String> translate(
    Session session,
    Caller caller, {
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) {
    final config = const ConfigSource().read().translation;
    if (text.length > config.maxTextLength) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return const MeteredCall().run(
      session,
      caller,
      kind: UsageKind.translation,
      isEnabled: config.enabled,
      perDay: config.perDay,
      request: () => _provider().translate(
        text: text,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }
}
