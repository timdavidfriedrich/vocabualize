import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/level.dart';
import 'package:vocabualize/features/core/services/pexels_api/image_model.dart';
import 'package:vocabualize/features/practise/services/answer.dart';
import 'package:vocabualize/features/practise/services/date_calculator.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Vocabulary {
  String _source = "";
  String _target = "";
  List<String> tags = [];
  ImageModel? _imageModel;
  File? cameraImageFile;
  Level level = Level();
  bool isNovice = true;
  //int noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  int interval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  double ease = Provider.of<SettingsProvider>(Keys.context, listen: false).initialEase;
  DateTime creationDate = DateTime.now();
  DateTime nextDate = DateTime.now();

  Vocabulary({required String source, required String target, tags})
      : _target = target,
        _source = source,
        tags = tags ?? [];

  Vocabulary.fromJson(Map<String, dynamic> json) {
    _source = json['source'];
    _target = json['target'];
    for (dynamic voc in json["tags"]) {
      tags.add(voc.toString());
    }
    _imageModel = ImageModel.fromJson(json["imageModel"]);
    if (json['cameraImageFile'] != "" && json['cameraImageFile'] != null) {
      cameraImageFile = File.fromRawPath(base64Decode(json['cameraImageFile']));
    }
    level.value = json['level'];
    isNovice = json['isNovice'];
    //noviceInterval = json['noviceInterval'];
    interval = json['interval'];
    ease = json['ease'];
    creationDate = DateTime.fromMillisecondsSinceEpoch(json['creationDate']);
    nextDate = DateTime.fromMillisecondsSinceEpoch(json['nextDate']);
  }

  Map<String, dynamic> toJson() => {
        'source': _source,
        'target': _target,
        'tags': tags,
        'imageModel': _imageModel?.toJson() ?? ImageModel.fallback().toJson(),
        'cameraImageFile': cameraImageFile == null ? "" : base64Encode(cameraImageFile!.readAsBytesSync()),
        'level': level.value,
        'isNovice': isNovice,
        //'noviceInterval': noviceInterval,
        'interval': interval,
        'ease': ease,
        'creationDate': creationDate.millisecondsSinceEpoch,
        'nextDate': nextDate.millisecondsSinceEpoch,
      };

  String get source => _source;
  String get target => _target;

  ImageModel get imageModel {
    return _imageModel ?? ImageModel.fallback();
  }

  ImageProvider get imageProvider {
    if (_imageModel != null) return CachedNetworkImageProvider(_imageModel!.src["large"]);
    if (cameraImageFile != null) return FileImage(cameraImageFile!);
    return NetworkImage(ImageModel.fallback().url);
  }

  bool get isNotNovice => !isNovice;

  set source(String source) {
    _source = source;
    save();
  }

  set target(String target) {
    _target = target;
    save();
  }

  void addTag(String tag) {
    tags.add(tag);
    save();
  }

  void deleteTag(String tag) {
    tags.remove(tag);
    save();
  }

  set imageModel(ImageModel imageModel) {
    _imageModel = imageModel;
    save();
  }

  Future<void> answer(Answer answer) async {
    nextDate = DateCalculator.nextDate(this, answer);
    await Provider.of<VocabularyProvider>(Keys.context, listen: false).save();
  }

  Future<void> save() async {
    await Provider.of<VocabularyProvider>(Keys.context, listen: false).save();
  }

  Future<void> reset() async {
    level.value = 0;
    isNovice = true;
    //noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
    interval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialInterval; // minutes
    await Provider.of<VocabularyProvider>(Keys.context, listen: false).save();
  }

  @override
  String toString() {
    return "$_source: \n\t'target': $_target, \n\t'tags': $tags, \n\t'level': $level, \n\t'isNovice': $isNovice, " /*\n\t'noviceInterval': $noviceInterval*/
        ", \n\t'interval': $interval, \n\t'ease': $ease, \n\t'creationDate': $creationDate, \n\t'nextDate': $nextDate";
  }
}
