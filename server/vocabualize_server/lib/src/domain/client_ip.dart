import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

const _clientIpHeader = "x-client-ip";
const _unknownClient = "unknown";
const _hashKeyLabel = "vocabualize:client-ip";

String clientIpHash(Session session) {
  final ip = switch (session) {
    MethodCallSession(:final request) => request.headers[_clientIpHeader]?.firstOrNull?.trim(),
    _ => null,
  };
  final secret = Serverpod.instance.config.serviceSecret;
  if (secret == null) throw StateError("Missing serviceSecret in config/passwords.yaml");
  final key = Hmac(sha256, utf8.encode(secret)).convert(utf8.encode(_hashKeyLabel)).bytes;
  return Hmac(
    sha256,
    key,
  ).convert(utf8.encode(ip == null || ip.isEmpty ? _unknownClient : ip)).toString();
}
