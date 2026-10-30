import 'package:serverpod/serverpod.dart';

import '../adapters/image_labeling/image_labeling_provider.dart';
import '../generated/protocol.dart';
import 'caller.dart';
import 'config_source.dart';
import 'metered_call.dart';
import 'usage_quota.dart';

const _invalidRequest = "invalidRequest";

class const ImageLabelingService(
  final ImageLabelingProvider Function() _provider,
) {
  Future<List<RemoteImageLabel>> label(
    Session session,
    Caller caller, {
    required List<int> image,
    required String language,
  }) async {
    final config = const ConfigSource().read().imageLabeling;
    if (image.length > config.maxImageBytes) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    final labeled = await const MeteredCall().run(
      session,
      caller,
      kind: UsageKind.imageLabeling,
      isEnabled: config.enabled,
      perDay: config.perDay,
      request: (_) => _provider().label(image: image, language: language),
    );
    session.log(
      "${UsageKind.imageLabeling.name} used ${labeled.inputTokens} input and "
      "${labeled.outputTokens} output tokens",
    );
    return labeled.labels;
  }
}
