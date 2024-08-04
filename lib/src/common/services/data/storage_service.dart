import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/models/vocabulary.dart';

class StorageService {
  static StorageService instance = StorageService();

  final String _bucketName = FirebaseStorage.instance.bucket;
  final Reference _itemImages = FirebaseStorage.instance.ref().child("vocabulary_images");

  Reference _getImageRefOfVocabulary(Vocabulary vocabulary) {
    return _itemImages.child(vocabulary.id).child(vocabulary.id);
  }

  Future<void> uploadVocabularyImage({required Uint8List imageData, required Vocabulary vocabulary}) async {
    try {
      await _getImageRefOfVocabulary(vocabulary).putData(imageData);
    } catch (e) {
      Log.error("Failed to upload image for vocabulary ${vocabulary.source} (${vocabulary.id}).", exception: e);
    }
  }

  String getVocabularyImageDownloadUrl({required Vocabulary vocabulary}) {
    return "gs://$_bucketName/${_getImageRefOfVocabulary(vocabulary).fullPath}";
  }

  Future<Uint8List?> downloadItemImage({required Vocabulary vocabulary}) async {
    try {
      final Uint8List? imageData = await _getImageRefOfVocabulary(vocabulary).getData();
      return imageData;
    } catch (e) {
      Log.error("Failed to download image for vocabulary ${vocabulary.source} (${vocabulary.id}).", exception: e);
      return null;
    }
  }
}
