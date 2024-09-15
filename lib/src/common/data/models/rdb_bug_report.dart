class RdbBugReport {
  final String id;
  final bool done;
  final String description;
  final String? data;
  final String created;
  final String updated;

  RdbBugReport({
    this.id = "",
    required this.done,
    required this.description,
    this.data,
    this.created = "",
    this.updated = "",
  });
}
