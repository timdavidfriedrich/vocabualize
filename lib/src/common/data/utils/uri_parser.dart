import 'package:log/log.dart';

class UriParser {
  static Uri parse(String uri, {String? fallbackUrl}) {
    try {
      return Uri.parse(uri);
    } on FormatException catch (e) {
      if (fallbackUrl != null) {
        Log.warning(
          "Failed to parse URI: '$uri'. Using fallback URL: '$fallbackUrl'.",
        );
        return parse(fallbackUrl);
      }
      Log.error(
        "Failed to parse URI: '$uri'. No fallback URL provided.",
        exception: e,
      );
      rethrow;
    }
  }

  static Uri parseWithParameters({
    required String uri,
    required Map<String, String> parameters,
    String? fallbackUrl,
  }) {
    String uriWithParameters = uri;
    for (int index = 0; index < parameters.length; index++) {
      final String separator = index == 0 ? "?" : "&";
      final String key = parameters.keys.elementAt(index);
      final String value = parameters.values.elementAt(index);
      uriWithParameters += "$separator$key=$value";
    }
    return parse(uriWithParameters, fallbackUrl: fallbackUrl);
  }
}
