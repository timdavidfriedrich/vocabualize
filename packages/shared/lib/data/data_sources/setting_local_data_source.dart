import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/models/local_language_settings.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _mainLanguageKey = "mainLanguage";
const _selectedLanguageKey = "selectedLanguage";
const _learnedLanguageKeyPrefix = "learnedLanguage.";
const _anyCharacters = "%";
const _adoptedLocalSpaceKey = "adoptedLocalSpace";

final _preferenceKeys = {for (final key in LocalPreferenceKey.values) key.value: key};

abstract class SettingLocalDataSource {
  Stream<LocalLanguageSettings> watchLanguageSettings();

  Future<LocalLanguageSettings> readLanguageSettings();

  Future<void> saveLanguageSettings({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  });

  Future<void> deleteLearnedLanguage(String languageCode);

  List<LocalSetting> createLanguageSettingRows({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  });

  Stream<Map<LocalPreferenceKey, String>> watchPreferences();

  Future<Map<LocalPreferenceKey, String>> readPreferences();

  Future<void> savePreference(
    LocalPreferenceKey key,
    String value, {
    required DateTime changedAt,
  });

  LocalSetting createAdoptionRecord({
    required UuidValue localOwnerId,
    required DateTime adoptedAt,
  });

  Future<bool> hasAdoptionRecord(UuidValue localOwnerId);
}

@Injectable(as: SettingLocalDataSource)
class const SettingLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements SettingLocalDataSource {
  @override
  Stream<LocalLanguageSettings> watchLanguageSettings() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? const Stream<LocalLanguageSettings>.empty()
          : LocalSetting.db
                .watch(
                  session,
                  where: _isLanguageSetting,
                  orderBy: (t) => t.changedAt.asc(),
                )
                .map(_latestLanguageSettings),
    );
  }

  @override
  Future<LocalLanguageSettings> readLanguageSettings() async {
    final settings = await LocalSetting.db.find(
      _requireSession(),
      where: _isLanguageSetting,
      orderBy: (t) => t.changedAt.asc(),
    );
    return _latestLanguageSettings(settings);
  }

  @override
  Future<void> saveLanguageSettings({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  }) {
    final session = _sessions.requireWritableSession();
    final timestamp = changedAt.toUtc();
    final values = {
      _mainLanguageKey: ?mainLanguage,
      _selectedLanguageKey: ?selectedLanguage,
      for (final MapEntry(key: languageCode, value: value) in learnedLanguages.entries)
        "$_learnedLanguageKeyPrefix$languageCode": value,
    };
    return session.db.transaction((transaction) async {
      for (final MapEntry(:key, :value) in values.entries) {
        await LocalSetting.db.deleteWhere(
          session,
          where: (t) => t.key.equals(key) & (t.changedAt < timestamp),
          transaction: transaction,
        );
        await LocalSetting.db.insertRow(
          session,
          LocalSetting(key: key, value: value, changedAt: timestamp),
          transaction: transaction,
        );
      }
    });
  }

  @override
  List<LocalSetting> createLanguageSettingRows({
    required String? mainLanguage,
    required String? selectedLanguage,
    required Map<String, String> learnedLanguages,
    required DateTime changedAt,
  }) {
    final timestamp = changedAt.toUtc();
    return [
      if (mainLanguage != null)
        LocalSetting(key: _mainLanguageKey, value: mainLanguage, changedAt: timestamp),
      if (selectedLanguage != null)
        LocalSetting(key: _selectedLanguageKey, value: selectedLanguage, changedAt: timestamp),
      for (final MapEntry(key: languageCode, :value) in learnedLanguages.entries)
        LocalSetting(
          key: "$_learnedLanguageKeyPrefix$languageCode",
          value: value,
          changedAt: timestamp,
        ),
    ];
  }

  @override
  Future<void> deleteLearnedLanguage(String languageCode) async {
    await LocalSetting.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.key.equals("$_learnedLanguageKeyPrefix$languageCode"),
    );
  }

  @override
  Stream<Map<LocalPreferenceKey, String>> watchPreferences() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? const Stream<Map<LocalPreferenceKey, String>>.empty()
          : LocalSetting.db
                .watch(
                  session,
                  where: (t) => t.key.inSet(_preferenceKeys.keys.toSet()),
                  orderBy: (t) => t.changedAt.asc(),
                )
                .map(_latestPreferences),
    );
  }

  @override
  Future<Map<LocalPreferenceKey, String>> readPreferences() async {
    final settings = await LocalSetting.db.find(
      _requireSession(),
      where: (t) => t.key.inSet(_preferenceKeys.keys.toSet()),
      orderBy: (t) => t.changedAt.asc(),
    );
    return _latestPreferences(settings);
  }

  @override
  Future<void> savePreference(
    LocalPreferenceKey key,
    String value, {
    required DateTime changedAt,
  }) {
    final session = _sessions.requireWritableSession();
    final timestamp = changedAt.toUtc();
    return session.db.transaction((transaction) async {
      await LocalSetting.db.deleteWhere(
        session,
        where: (t) => t.key.equals(key.value) & (t.changedAt < timestamp),
        transaction: transaction,
      );
      await LocalSetting.db.insertRow(
        session,
        LocalSetting(key: key.value, value: value, changedAt: timestamp),
        transaction: transaction,
      );
    });
  }

  @override
  LocalSetting createAdoptionRecord({
    required UuidValue localOwnerId,
    required DateTime adoptedAt,
  }) {
    return LocalSetting(
      key: _adoptedLocalSpaceKey,
      value: localOwnerId.uuid,
      changedAt: adoptedAt.toUtc(),
    );
  }

  @override
  Future<bool> hasAdoptionRecord(UuidValue localOwnerId) async {
    final record = await LocalSetting.db.findFirstRow(
      _requireSession(),
      where: (t) => t.key.equals(_adoptedLocalSpaceKey) & t.value.equals(localOwnerId.uuid),
    );
    return record != null;
  }

  Expression<dynamic> _isLanguageSetting(LocalSettingTable t) =>
      t.key.equals(_mainLanguageKey) |
      t.key.equals(_selectedLanguageKey) |
      t.key.like("$_learnedLanguageKeyPrefix$_anyCharacters");

  LocalLanguageSettings _latestLanguageSettings(List<LocalSetting> settings) {
    final latest = {for (final setting in settings) setting.key: setting.value};
    return LocalLanguageSettings(
      mainLanguage: latest[_mainLanguageKey],
      selectedLanguage: latest[_selectedLanguageKey],
      learnedLanguages: [
        for (final MapEntry(:key, :value) in latest.entries)
          if (key.startsWith(_learnedLanguageKeyPrefix)) value,
      ],
    );
  }

  Map<LocalPreferenceKey, String> _latestPreferences(List<LocalSetting> settings) {
    return {
      for (final setting in settings) ?_preferenceKeys[setting.key]: setting.value,
    };
  }

  OfflineSyncDatabaseSession _requireSession() {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open.");
    return session;
  }
}
