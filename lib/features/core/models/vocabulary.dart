import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/models/tag.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/core/services/text/language_service.dart';
import 'package:vocabualize/features/core/models/level.dart';
import 'package:vocabualize/features/core/services/messaging_service.dart';
import 'package:vocabualize/features/core/models/pexels_model.dart';
import 'package:vocabualize/features/core/utils/answer.dart';
import 'package:vocabualize/features/practise/utils/date_calculator.dart';
import 'package:vocabualize/features/record/widgets/duplicate_dialog.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Vocabulary {
  final String id;
  String _source = "";
  String _target = "";
  Language _sourceLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage;
  Language _targetLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage;
  List<Tag> tags = [];
  PexelsModel? _pexelsModel;
  File? _cameraImageFile;
  String? firebaseImageUrl;
  Level level = Level();
  bool isNovice = true;
  //int noviceInterval = Provider.of<SettingsProvider>(Keys.context, listen: false).initialNoviceInterval; // minutes
  int interval = Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval; // minutes
  double ease = Provider.of<SettingsProvider>(Global.context, listen: false).initialEase;
  DateTime created = DateTime.now();
  DateTime? updated = DateTime.now();
  DateTime nextDate = DateTime.now();

  Vocabulary({required String source, required String target, List<Tag>? tags})
      : id = "vocabulary--${const Uuid().v4()}",
        _source = source,
        _target = target,
        tags = tags ?? [];

  Vocabulary.empty() : id = "vocabulary--${const Uuid().v4()}";

  Vocabulary.fromJson(
    Map<String, dynamic> json, {
    List<Tag>? tags,
    List<Language>? languages,
  })  : id = json['id'] ?? "empty_id",
        tags = tags ?? [],
        _sourceLanguage = languages?.where((element) => element.id == json['sourceLanguage']).first ?? Language.defaultSource(),
        _targetLanguage = languages?.where((element) => element.id == json['targetLanguage']).first ?? Language.defaultTarget() {
    _source = json['source'];
    _target = json['target'];
    // initSourceLanguage(json['sourceLanguage']);
    // initTargetLanguage(json['targetLanguage']);
    _pexelsModel = PexelsModel.fromJson(json["pexelsModel"]);
    _cameraImageFile = json['cameraImageFile'] == null ? null : File(json['cameraImageFile']);

    // firebaseImageUrl = json['firebaseImageUrl'] ?? "";
    level.value = json['levelValue'] ?? 0.0;
    isNovice = json['isNovice'] ?? false;
    interval = json['interval'] ?? 0;
    ease = json['ease'] ?? 0;
    nextDate = json['nextDate'] != null && json['nextDate'] is String ? DateTime.parse(json['nextDate']) : DateTime.now();
    created = json['created'] != null ? DateTime.parse(json['created']) : DateTime.now();
    updated = json['updated'] != null ? DateTime.parse(json['updated']) : null;
  }

  Vocabulary.fromRecord(
    RecordModel recordModel, {
    List<Tag>? tags,
    List<Language>? languages,
  })  : id = recordModel.id,
        _source = recordModel.data['source'],
        _target = recordModel.data['target'],
        _sourceLanguage = languages?.where((element) => element.id == recordModel.data['sourceLanguage']).first ?? Language.defaultSource(),
        _targetLanguage = languages?.where((element) => element.id == recordModel.data['targetLanguage']).first ?? Language.defaultTarget(),
        tags = tags ?? [],
        _pexelsModel = PexelsModel.fromJson(recordModel.data['pexelsModel']),
        _cameraImageFile = recordModel.data['cameraImageFile'] == null ? null : File(recordModel.data['cameraImageFile']),
        // firebaseImageUrl = recordModel.data['firebaseImageUrl'],
        // level.value = recordModel.data['levelValue'] ?? 0.0,
        isNovice = recordModel.data['isNovice'] ?? false,
        interval = recordModel.data['interval'] ?? 0,
        ease = recordModel.data['ease'] ?? 0,
        nextDate = DateTime.tryParse(recordModel.data['nextDate'] ?? "") ?? DateTime.now(),
        created = DateTime.tryParse(recordModel.data['created'] ?? "") ?? DateTime.now(),
        updated = DateTime.tryParse(recordModel.data['updated'] ?? "");

  initSourceLanguage(String translatorId) async {
    _sourceLanguage = await LanguageService.findLanguage(translatorId: translatorId) ?? Language.defaultSource();
  }

  initTargetLanguage(String translatorId) async {
    _targetLanguage = await LanguageService.findLanguage(translatorId: translatorId) ?? Language.defaultTarget();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': _source,
        'target': _target,
        'sourceLanguage': _sourceLanguage.translatorId,
        'targetLanguage': _targetLanguage.translatorId,
        'tags': tags.map((e) => e.name).toList(),
        'pexelsModel': _pexelsModel?.toJson() ?? PexelsModel.fallback().toJson(),
        'cameraImageFile': _cameraImageFile?.path,
        'firebaseImageUrl': firebaseImageUrl,
        'level': level.value,
        'isNovice': isNovice,
        //'noviceInterval': noviceInterval,
        'interval': interval,
        'ease': ease,
        'creationDate': created.millisecondsSinceEpoch,
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

  // ImageProvider get imageProvider {
  //   if (_cameraImageFile != null) return FileImage(_cameraImageFile!);
  //   if (_pexelsModel != null) return CachedNetworkImageProvider(_pexelsModel!.src["large"]);
  //   return NetworkImage(PexelsModel.fallback().url);
  // }

  ImageProvider get imageProvider {
    if (_cameraImageFile != null) return FileImage(_cameraImageFile!);
    if (_pexelsModel != null && firebaseImageUrl == null) {
      return CachedNetworkImageProvider(_pexelsModel!.src["large"]);
    }
    try {
      ImageProvider? provider = FirebaseImageProvider(
        FirebaseUrl(firebaseImageUrl!),
        options: const CacheOptions(
          checkIfFileUpdatedOnServer: false,
        ),
      );
      return provider;
    } catch (e) {
      Log.error(e);
      return NetworkImage(PexelsModel.fallback().url);
    }
  }

  Widget get image {
    return Image(
      fit: BoxFit.cover,
      image: imageProvider,
      frameBuilder: (_, child, frame, __) {
        if (frame == null) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return child;
      },
    );
  }

  // Widget? get image {
  //   if (firebaseImageUrl == null) return null;
  //   try {
  //     if (imageProvider == null) {
  //       return const ErrorInfo();
  //     }
  //     return Image(
  //       fit: BoxFit.cover,
  //       image: imageProvider!,
  //       frameBuilder: (_, child, frame, __) {
  //         if (frame == null) {
  //           return const Center(
  //             child: CircularProgressIndicator.adaptive(),
  //           );
  //         }
  //         return child;
  //       },
  //     );
  //   } catch (e) {
  //     return ErrorInfo(message: e.toString());
  //   }
  // }

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

  void addTag(Tag tag) {
    tags.add(tag);
    save();
  }

  void deleteTag(Tag tag) {
    tags.remove(tag);
    save();
  }

  bool isValid() {
    bool sourceNotEmpty = source.isNotEmpty;
    bool alreadyInList = Provider.of<VocabularyProvider>(Global.context, listen: false).searchListForSource(source) != null;
    if (alreadyInList) MessangingService.showStaticDialog(DuplicateDialog(vocabulary: this));
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
    return "$id: \n\t'source': $_source, \n\t'target': $_target, \n\t'tags': $tags, \n\t'level': $level, \n\t'isNovice': $isNovice, " /*\n\t'noviceInterval': $noviceInterval*/
        ", \n\t'interval': $interval, \n\t'ease': $ease, \n\t'creationDate': $created, \n\t'nextDate': $nextDate, \n\t'sourceLanguage': $sourceLanguage, \n\t'targetLanguage': $targetLanguage";
  }
}
