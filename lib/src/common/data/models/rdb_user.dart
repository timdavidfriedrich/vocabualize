class RdbUser {
  final String id;
  final String? username;
  final String email;
  final String name;
  final String? avatarUrl;
  final String created;
  final String updated;

  const RdbUser({
    this.id = "",
    this.username,
    this.email = "",
    this.name = "",
    this.avatarUrl,
    this.created = "",
    this.updated = "",
  });
}
