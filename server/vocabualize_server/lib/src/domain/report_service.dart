import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'client_ip.dart';
import 'config_source.dart';
import 'languages.dart';
import 'owner_lock.dart';

const reportFeedback = "feedback";
const reportTranslation = "translation";

const _disabled = "disabled";
const _limited = "limited";
const _invalidRequest = "invalidRequest";
const _maxWordLength = 200;
const _maxContextLength = 64;
const _reportsLockKey = "vocabualize:reports";
const _hour = Duration(hours: 1);
const _day = Duration(days: 1);

final _controlCharacters = RegExp(r"[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F]");

class const ReportService() {
  Future<void> sendFeedback(
    Session session, {
    required String message,
    required RemoteReportContext context,
  }) {
    final config = const ConfigSource().read().reports;
    final text = _clean(message, maxLength: config.maxMessageLength);
    if (text.isEmpty) throw ReportRejectedException(reason: _invalidRequest);
    return _store(
      session,
      config,
      _report(session, kind: reportFeedback, message: text, context: context),
    );
  }

  Future<void> sendTranslationReport(
    Session session, {
    required String source,
    required String target,
    required String sourceLanguage,
    required String targetLanguage,
    required String note,
    required RemoteReportContext context,
  }) {
    final config = const ConfigSource().read().reports;
    final cleanSource = _clean(source, maxLength: _maxWordLength);
    final cleanTarget = _clean(target, maxLength: _maxWordLength);
    if (cleanSource.isEmpty ||
        cleanTarget.isEmpty ||
        !supportedLanguages.containsKey(sourceLanguage) ||
        !supportedLanguages.containsKey(targetLanguage)) {
      throw ReportRejectedException(reason: _invalidRequest);
    }
    return _store(
      session,
      config,
      _report(
        session,
        kind: reportTranslation,
        message: _clean(note, maxLength: config.maxMessageLength),
        context: context,
      ).copyWith(
        source: cleanSource,
        target: cleanTarget,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      ),
    );
  }

  Report _report(
    Session session, {
    required String kind,
    required String message,
    required RemoteReportContext context,
  }) {
    return Report(
      kind: kind,
      message: message,
      appVersion: _clean(context.appVersion, maxLength: _maxContextLength),
      platform: _clean(context.platform, maxLength: _maxContextLength),
      appLanguage: _clean(context.appLanguage, maxLength: _maxContextLength),
      languages: _clean(context.languages, maxLength: _maxContextLength),
      authUserId: switch (session.authenticated?.userIdentifier) {
        final String identifier => UuidValue.withValidation(identifier),
        null => null,
      },
      ipHash: clientIpHash(session),
      createdAt: DateTime.now().toUtc(),
    );
  }

  Future<void> _store(Session session, ReportsConfig config, Report report) async {
    if (!config.enabled) throw ReportRejectedException(reason: _disabled);
    await session.db.transaction((transaction) async {
      await lockKey(session, _reportsLockKey, transaction);
      final now = report.createdAt;
      final sentToday = await Report.db.count(
        session,
        where: (t) => t.createdAt > now.subtract(_day),
        transaction: transaction,
      );
      final sentFromIpToday = await Report.db.count(
        session,
        where: (t) => t.ipHash.equals(report.ipHash) & (t.createdAt > now.subtract(_day)),
        transaction: transaction,
      );
      final sentFromIpThisHour = await Report.db.count(
        session,
        where: (t) => t.ipHash.equals(report.ipHash) & (t.createdAt > now.subtract(_hour)),
        transaction: transaction,
      );
      if (sentToday >= config.perDay ||
          sentFromIpToday >= config.perIpPerDay ||
          sentFromIpThisHour >= config.perIpPerHour) {
        throw ReportRejectedException(reason: _limited);
      }
      await Report.db.insertRow(session, report, transaction: transaction);
    });
  }

  String _clean(String text, {required int maxLength}) {
    final cleaned = text.replaceAll(_controlCharacters, "").trim();
    if (cleaned.length > maxLength) throw ReportRejectedException(reason: _invalidRequest);
    return cleaned;
  }
}
