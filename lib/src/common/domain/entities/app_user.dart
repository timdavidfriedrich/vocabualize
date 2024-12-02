import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';

class AppUser {
  final String? id;
  final String? username;
  final String? name;
  final String? email;
  final bool? emailVisibility;
  final bool? verified;
  final String? avatarUrl;
  final DateTime? created;
  final DateTime? updated;

  String get displayName {
    return name?.takeUnless((n) => n.isEmpty) ??
        username?.takeUnless((n) => n.isEmpty) ??
        "Anonymous";
  }

  String get info {
    return email?.takeUnless((e) => e.isEmpty) ?? "No email";
  }

  const AppUser({
    this.id,
    this.username,
    this.name,
    this.email,
    this.emailVisibility,
    this.verified,
    this.avatarUrl,
    this.created,
    this.updated,
  });

  @override
  String toString() {
    return "AppUser("
        "id: $id, "
        "username: $username, "
        "name: $name, "
        "email: $email, "
        "emailVisibility: $emailVisibility, "
        "verified: $verified, "
        "avatarUrl: $avatarUrl, "
        "created: $created, "
        "updated: $updated"
        ")";
  }

  @override
  // ignore: hash_and_equals
  operator ==(Object other) {
    if (other is AppUser) {
      return id == other.id;
    }
    return false;
  }
}
