import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'client_ip.dart';
import 'config_source.dart';
import 'owner_lock.dart';

const _disabled = "disabled";
const _limited = "limited";
const _invalidKey = "invalidKey";
const _installsLockKey = "vocabualize:installs";
// * 32 random bytes give the secret 256 bits of entropy, so a fast SHA-256 hash is enough to store it
const _secretBytes = 32;
const _byteValues = 256;
const _day = Duration(days: 1);

final _random = Random.secure();

class const InstallRegistry() {
  Future<RemoteInstallKey> register(Session session) async {
    final config = const ConfigSource().read().installs;
    if (!config.enabled) throw InstallRejectedException(reason: _disabled);
    final ipHash = clientIpHash(session);
    final secret = base64Url
        .encode([for (var i = 0; i < _secretBytes; i++) _random.nextInt(_byteValues)])
        .replaceAll("=", "");
    final install = await session.db.transaction((transaction) async {
      await lockKey(session, _installsLockKey, transaction);
      final now = DateTime.now().toUtc();
      final since = now.subtract(_day);
      final registeredToday = await Install.db.count(
        session,
        where: (t) => t.createdAt > since,
        transaction: transaction,
      );
      final registeredFromIpToday = await Install.db.count(
        session,
        where: (t) => t.ipHash.equals(ipHash) & (t.createdAt > since),
        transaction: transaction,
      );
      if (registeredToday >= config.perDay || registeredFromIpToday >= config.perIpPerDay) {
        throw InstallRejectedException(reason: _limited);
      }
      return Install.db.insertRow(
        session,
        Install(secretHash: _hash(secret), ipHash: ipHash, createdAt: now, lastUsedAt: now),
        transaction: transaction,
      );
    });
    return RemoteInstallKey(installId: install.id!.uuid, secret: secret);
  }

  Future<UuidValue> verify(Session session, RemoteInstallKey key) async {
    final install = await _find(session, key);
    if (install == null) throw InstallRejectedException(reason: _invalidKey);
    final now = DateTime.now().toUtc();
    if (!_isSameDay(install.lastUsedAt, now)) {
      await Install.db.updateRow(
        session,
        install.copyWith(lastUsedAt: now),
        columns: (t) => [t.lastUsedAt],
      );
    }
    return install.id!;
  }

  Future<void> delete(Session session, RemoteInstallKey key) async {
    final install = await _find(session, key);
    if (install == null) return;
    await session.db.transaction((transaction) async {
      await ServiceUsage.db.deleteWhere(
        session,
        where: (t) => t.ownerId.equals(install.id),
        transaction: transaction,
      );
      await Install.db.deleteRow(session, install, transaction: transaction);
    });
  }

  Future<Install?> _find(Session session, RemoteInstallKey key) async {
    final UuidValue installId;
    try {
      installId = UuidValue.withValidation(key.installId);
    } on FormatException {
      return null;
    }
    final install = await Install.db.findById(session, installId);
    if (install == null || !_isEqual(_hash(key.secret), install.secretHash)) return null;
    return install;
  }
}

String _hash(String secret) => sha256.convert(utf8.encode(secret)).toString();

bool _isEqual(String first, String second) {
  if (first.length != second.length) return false;
  var difference = 0;
  for (var index = 0; index < first.length; index++) {
    difference |= first.codeUnitAt(index) ^ second.codeUnitAt(index);
  }
  return difference == 0;
}

bool _isSameDay(DateTime first, DateTime second) {
  final firstUtc = first.toUtc();
  final secondUtc = second.toUtc();
  return firstUtc.year == secondUtc.year &&
      firstUtc.month == secondUtc.month &&
      firstUtc.day == secondUtc.day;
}
