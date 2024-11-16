class Tag {
  final String? id;
  final String name;
  final DateTime? created;
  final DateTime? updated;

  const Tag({
    this.id,
    this.name = "",
    this.created,
    this.updated,
  });

  Tag copyWith({
    String? id,
    String? name,
    DateTime? created,
    DateTime? updated,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  String toString() {
    return "Tag(id: $id, name: $name, created: $created, updated: $updated)";
  }
}
