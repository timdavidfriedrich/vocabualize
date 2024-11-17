// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vocabualize/constants/image_constants.dart';

// ! TODO: Use new classes to get new image fields and then check which ones are available and convert to entities after fetching
// if id null or field null return null

abstract interface class RdbImage {
  abstract final String id;
}

class RdbStockImage implements RdbImage {
  @override
  final String id;
  final int width;
  final int height;
  final String url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerID;
  final String? avgColor;
  final Map<String, dynamic>? src;

  const RdbStockImage({
    this.id = "unknown",
    this.width = ImageConstants.fallbackImageWidth,
    this.height = ImageConstants.fallbackImageHeight,
    this.url = ImageConstants.fallbackImageUrl,
    this.photographer,
    this.photographerUrl,
    this.photographerID,
    this.avgColor,
    this.src,
  });
}

class RdbCustomImage implements RdbImage {
  @override
  final String id;
  final String fileName;

  const RdbCustomImage({
    required this.id,
    required this.fileName,
  });
}

// TODO: Remove old RdbVocabualaryImage class
enum RdbVocabularyImageType {
  stock,
  custom,
}

class RdbVocabualaryImage {
  final RdbVocabularyImageType type;
  final String id;
  final int width;
  final int height;
  final String url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerID;
  final String? avgColor;
  final Map<String, dynamic>? src;

  const RdbVocabualaryImage({
    required this.type,
    this.id = "unknown",
    this.width = ImageConstants.fallbackImageWidth,
    this.height = ImageConstants.fallbackImageHeight,
    this.url = ImageConstants.fallbackImageUrl,
    this.photographer,
    this.photographerUrl,
    this.photographerID,
    this.avgColor,
    this.src,
  });

  // TODO: Is this method still needed?
  factory RdbVocabualaryImage.fromRecord(Map<String, dynamic> json, {required RdbVocabularyImageType type}) {
    return RdbVocabualaryImage(
      type: RdbVocabularyImageType.values.firstWhere(
        (t) => t.name == json['type'] as String?,
        orElse: () => type,
      ),
      id: (json['id'] as int?).toString(),
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['src']['original'] as String,
      photographer: json['photographer'] != null ? json['photographer'] as String : null,
      photographerUrl: json['photographerUrl'] != null ? json['photographerUrl'] as String : null,
      photographerID: json['photographerID'] != null ? json['photographerID'] as int : null,
      avgColor: json['avgColor'] != null ? json['avgColor'] as String : null,
      src: json['src'] != null ? Map<String, dynamic>.from(json['src'] as Map<String, dynamic>) : null,
    );
  }
}
