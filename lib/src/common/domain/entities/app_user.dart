class AppUser {
  final String id;
  final String? name;
  final bool verified;
  final DateTime? created;
  final DateTime? updated;
  final DateTime? lastLogin;

  AppUser({
    this.id = "",
    this.name = "Unknown",
    this.verified = true, // TODO: Change default verified value to false
    this.created,
    this.updated,
    this.lastLogin,
  });

  @override
  String toString() {
    return "AppUser(id: $id, name: $name, verified: $verified, created: $created, updated: $updated, lastLogin: $lastLogin)";
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
