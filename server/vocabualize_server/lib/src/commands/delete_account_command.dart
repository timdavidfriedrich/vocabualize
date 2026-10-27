import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart';

import '../domain/account_deletion.dart';
import '../generated/protocol.dart';

const deleteAccountCommand = "delete-account";

const _confirmFlag = "--confirm";
const _usage = "Usage: $deleteAccountCommand <email> [$_confirmFlag]";
const _success = 0;
const _failure = 1;

class const DeleteAccountCommand() {
  Future<int> run(Session session, List<String> args) async {
    final email = args.where((arg) => !arg.startsWith("-")).firstOrNull?.trim().toLowerCase();
    if (email == null || email.isEmpty) {
      stderr.writeln(_usage);
      return _failure;
    }
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (profile == null) {
      stderr.writeln("No account with the email address $email.");
      return _failure;
    }
    final userId = profile.authUserId;
    final space = await OfflineSyncSpace.db.findFirstRow(
      session,
      where: (t) => t.uuidSpaceId.equals(userId),
    );
    final spaceId = space?.id;
    final words = spaceId == null
        ? 0
        : await LocalVocabulary.db.count(session, where: (t) => t.spaceId.equals(spaceId));
    final photos = await StoredImage.db.count(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    stdout.writeln("Account ${userId.uuid} ($email): $words words, $photos stored photo files.");
    if (!args.contains(_confirmFlag)) {
      stdout.writeln("Dry run. Repeat with $_confirmFlag to delete this account and all its data.");
      return _success;
    }
    await const AccountDeletion().delete(session, userId);
    stdout.writeln("Deleted account ${userId.uuid} and all its data.");
    return _success;
  }
}
