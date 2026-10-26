import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _languagePairKey = "languagePair";
const _adoptedLocalSpaceKey = "adoptedLocalSpace";

final _preferenceKeys = {for (final key in LocalPreferenceKey.values) key.value: key};

abstract class SettingLocalDataSource {
  Stream<LocalSetting?> watchLanguagePair();

  Future<LocalSetting?> readLanguagePair();

  LocalSetting createLanguagePair({
    required String value,
    required DateTime changedAt,
  });

  Future<void> insertSetting(LocalSetting setting);

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
  Stream<LocalSetting?> watchLanguagePair() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? const Stream<LocalSetting?>.empty()
          : LocalSetting.db
                .watch(
                  session,
                  where: (t) => t.key.equals(_languagePairKey),
                  orderBy: (t) => t.changedAt.desc(),
                  limit: 1,
                )
                .map((settings) => settings.firstOrNull),
    );
  }

  @override
  Future<LocalSetting?> readLanguagePair() {
    return LocalSetting.db.findFirstRow(
      _requireSession(),
      where: (t) => t.key.equals(_languagePairKey),
      orderBy: (t) => t.changedAt.desc(),
    );
  }

  @override
  LocalSetting createLanguagePair({
    required String value,
    required DateTime changedAt,
  }) {
    return LocalSetting(key: _languagePairKey, value: value, changedAt: changedAt.toUtc());
  }

  @override
  Future<void> insertSetting(LocalSetting setting) async {
    await LocalSetting.db.insertRow(_sessions.requireWritableSession(), setting);
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
