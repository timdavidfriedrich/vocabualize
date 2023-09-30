import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/core/services/languages.dart';
import 'package:vocabualize/features/core/services/level.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/pexels_api/pexels_model.dart';
import 'package:vocabualize/features/core/services/answer.dart';
import 'package:vocabualize/features/practise/services/date_calculator.dart';
import 'package:vocabualize/features/record/widgets/duplicate_dialog.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Vocabulary {
  String _source = "";
  String _target = "";
  Language _sourceLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage;
  Language _targetLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage;
  List<String> tags = [];
  PexelsModel? _pexelsModel;
  File? _cameraImageFile;
  Level level = Level();
  bool isNovice = true;
  //int noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  int interval = Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval; // minutes
  double ease = Provider.of<SettingsProvider>(Global.context, listen: false).initialEase;
  DateTime creationDate = DateTime.now();
  DateTime nextDate = DateTime.now();

  Vocabulary({required String source, required String target, tags})
      : _source = source,
        _target = target,
        tags = tags ?? [];

  Vocabulary.empty();

  Vocabulary.fromJson(Map<String, dynamic> json) {
    _source = json['source'];
    _target = json['target'];
    initSourceLanguage(json['sourceLanguage']);
    initTargetLanguage(json['targetLanguage']);
    for (dynamic voc in json["tags"]) {
      tags.add(voc.toString());
    }
    _pexelsModel = PexelsModel.fromJson(json["pexelsModel"]);
    _cameraImageFile = json['cameraImageFile'] == null ? null : File(json['cameraImageFile']);
    level.value = json['level'];
    isNovice = json['isNovice'];
    //noviceInterval = json['noviceInterval'];
    interval = json['interval'];
    ease = json['ease'];
    creationDate = DateTime.fromMillisecondsSinceEpoch(json['creationDate']);
    nextDate = DateTime.fromMillisecondsSinceEpoch(json['nextDate']);
  }

  initSourceLanguage(String translatorId) async {
    _sourceLanguage = await Languages.findLanguage(translatorId: translatorId) ?? Language.defaultSource();
  }

  initTargetLanguage(String translatorId) async {
    _targetLanguage = await Languages.findLanguage(translatorId: translatorId) ?? Language.defaultTarget();
  }

  Map<String, dynamic> toJson() => {
        'source': _source,
        'target': _target,
        'sourceLanguage': _sourceLanguage.translatorId,
        'targetLanguage': _targetLanguage.translatorId,
        'tags': tags,
        'pexelsModel': _pexelsModel?.toJson() ?? PexelsModel.fallback().toJson(),
        'cameraImageFile': _cameraImageFile?.path,
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
  Language get sourceLanguage => _sourceLanguage;
  Language get targetLanguage => _targetLanguage;

  PexelsModel get pexelsModel {
    return _pexelsModel ?? PexelsModel.fallback();
  }

  bool get hasImage {
    return _pexelsModel != null || _cameraImageFile != null;
  }

  File? get cameraImageFile => _cameraImageFile;

  ImageProvider get imageProvider {
    if (_cameraImageFile != null) return FileImage(_cameraImageFile!);
    if (_pexelsModel != null) return CachedNetworkImageProvider(_pexelsModel!.src["large"]);
    return NetworkImage(PexelsModel.fallback().url);
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

  set sourceLanguage(Language sourceLanguage) {
    _sourceLanguage = sourceLanguage;
    save();
  }

  set targetLanguage(Language targetLanguage) {
    _targetLanguage = targetLanguage;
    save();
  }

  set cameraImageFile(File? file) {
    _cameraImageFile = file;
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

  bool isValid() {
    bool sourceNotEmpty = source.isNotEmpty;
    bool alreadyInList = Provider.of<VocabularyProvider>(Global.context, listen: false).searchListForSource(source) != null;
    if (alreadyInList) Messenger.showStaticDialog(DuplicateDialog(vocabulary: this));
    return sourceNotEmpty && !alreadyInList;
  }

  set pexelsModel(PexelsModel pexelsModel) {
    _pexelsModel = pexelsModel;
    save();
  }

  Future<void> answer(Answer answer) async {
    nextDate = DateCalculator.nextDate(this, answer);
    Provider.of<VocabularyProvider>(Global.context, listen: false).save();
  }

  Future<void> save() async {
    Provider.of<VocabularyProvider>(Global.context, listen: false).save();
  }

  Future<void> reset() async {
    level.value = 0;
    isNovice = true;
    //noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
    interval = Provider.of<SettingsProvider>(Global.context, listen: false).initialInterval; // minutes
    Provider.of<VocabularyProvider>(Global.context, listen: false).save();
  }

  @override
  String toString() {
    return "$_source: \n\t'target': $_target, \n\t'tags': $tags, \n\t'level': $level, \n\t'isNovice': $isNovice, " /*\n\t'noviceInterval': $noviceInterval*/
        ", \n\t'interval': $interval, \n\t'ease': $ease, \n\t'creationDate': $creationDate, \n\t'nextDate': $nextDate, \n\t'sourceLanguage': $sourceLanguage, \n\t'targetLanguage': $targetLanguage";
  }
}
