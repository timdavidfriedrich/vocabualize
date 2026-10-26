/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:serverpod/serverpod.dart' as _is;

abstract class Install implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Install._({
    this.id,
    required this.secretHash,
    required this.ipHash,
    required this.createdAt,
    required this.lastUsedAt,
  });

  factory Install({
    _is.UuidValue? id,
    required String secretHash,
    required String ipHash,
    required DateTime createdAt,
    required DateTime lastUsedAt,
  }) = _InstallImpl;

  factory Install.fromJson(Map<String, dynamic> jsonSerialization) {
    return Install(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      secretHash: jsonSerialization['secretHash'] as String,
      ipHash: jsonSerialization['ipHash'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastUsedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastUsedAt']),
    );
  }

  static final t = InstallTable();

  static const db = InstallRepository._();

  @override
  _is.UuidValue? id;

  String secretHash;

  String ipHash;

  DateTime createdAt;

  DateTime lastUsedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Install]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Install copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    String? secretHash,
    String? ipHash,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Install',
      if (id != null) 'id': id?.toJson(),
      'secretHash': secretHash,
      'ipHash': ipHash,
      'createdAt': createdAt.toJson(),
      'lastUsedAt': lastUsedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static InstallInclude include() {
    return InstallInclude._();
  }

  static InstallIncludeList includeList({
    _is.WhereExpressionBuilder<InstallTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    InstallInclude? include,
  }) {
    return InstallIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InstallImpl extends Install {
  _InstallImpl({
    _is.UuidValue? id,
    required String secretHash,
    required String ipHash,
    required DateTime createdAt,
    required DateTime lastUsedAt,
  }) : super._(
         id: id,
         secretHash: secretHash,
         ipHash: ipHash,
         createdAt: createdAt,
         lastUsedAt: lastUsedAt,
       );

  /// Returns a shallow copy of this [Install]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Install copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    String? secretHash,
    String? ipHash,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  }) {
    return Install(
      id: id is _is.UndefinedSentinel ? this.id : id,
      secretHash: secretHash ?? this.secretHash,
      ipHash: ipHash ?? this.ipHash,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }
}

class InstallUpdateTable extends _is.UpdateTable<InstallTable> {
  InstallUpdateTable(super.table);

  _is.ColumnValue<String, String> secretHash(String value) => _is.ColumnValue(
    table.secretHash,
    value,
  );

  _is.ColumnValue<String, String> ipHash(String value) => _is.ColumnValue(
    table.ipHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) => _is.ColumnValue(
    table.createdAt,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastUsedAt(DateTime value) => _is.ColumnValue(
    table.lastUsedAt,
    value,
  );
}

class InstallTable extends _is.Table<_is.UuidValue?> {
  InstallTable({super.tableRelation}) : super(tableName: 'install') {
    updateTable = InstallUpdateTable(this);
    secretHash = _is.ColumnString(
      'secretHash',
      this,
    );
    ipHash = _is.ColumnString(
      'ipHash',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    lastUsedAt = _is.ColumnDateTime(
      'lastUsedAt',
      this,
    );
  }

  late final InstallUpdateTable updateTable;

  late final _is.ColumnString secretHash;

  late final _is.ColumnString ipHash;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime lastUsedAt;

  @override
  List<_is.Column> get columns => [
    id,
    secretHash,
    ipHash,
    createdAt,
    lastUsedAt,
  ];
}

class InstallInclude extends _is.IncludeObject {
  InstallInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => Install.t;
}

class InstallIncludeList extends _is.IncludeList {
  InstallIncludeList._({
    _is.WhereExpressionBuilder<InstallTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Install.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Install.t;
}

class InstallRepository {
  const InstallRepository._();

  /// Returns a list of [Install]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Install>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InstallTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Install>(
      where: where?.call(Install.t),
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Install]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `Install.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<Install>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InstallTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Install>(
      where: where?.call(Install.t),
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Install] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Install?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InstallTable>? where,
    int? offset,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Install>(
      where: where?.call(Install.t),
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Install] by its [id] or null if no such row exists.
  Future<Install?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Install>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Install]s in the list and returns the inserted rows.
  ///
  /// The returned [Install]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> insert(
    _is.DatabaseSession session,
    List<Install> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Install>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Install] and returns the inserted row.
  ///
  /// The returned [Install] will have its `id` field set.
  Future<Install> insertRow(
    _is.DatabaseSession session,
    Install row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Install>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Install]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Install]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> upsert(
    _is.DatabaseSession session,
    List<Install> rows, {
    required _is.ColumnSelections<InstallTable> conflictColumns,
    _is.ColumnSelections<InstallTable>? updateColumns,
    _is.WhereExpressionBuilder<InstallTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Install>(
      rows,
      conflictColumns: conflictColumns(Install.t),
      updateColumns: updateColumns?.call(Install.t),
      updateWhere: updateWhere?.call(Install.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Install] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Install] will have its `id` field set.
  Future<Install?> upsertRow(
    _is.DatabaseSession session,
    Install row, {
    required _is.ColumnSelections<InstallTable> conflictColumns,
    _is.ColumnSelections<InstallTable>? updateColumns,
    _is.WhereExpressionBuilder<InstallTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Install>(
      row,
      conflictColumns: conflictColumns(Install.t),
      updateColumns: updateColumns?.call(Install.t),
      updateWhere: updateWhere?.call(Install.t),
      transaction: transaction,
    );
  }

  /// Updates all [Install]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> update(
    _is.DatabaseSession session,
    List<Install> rows, {
    _is.ColumnSelections<InstallTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Install>(
      rows,
      columns: columns?.call(Install.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Install]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Install> updateRow(
    _is.DatabaseSession session,
    Install row, {
    _is.ColumnSelections<InstallTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Install>(
      row,
      columns: columns?.call(Install.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Install] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Install?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<InstallUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Install>(
      id,
      columnValues: columnValues(Install.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Install]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InstallUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InstallTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Install>(
      columnValues: columnValues(Install.t.updateTable),
      where: where(Install.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Install]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> delete(
    _is.DatabaseSession session,
    List<Install> rows, {
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Install>(
      rows,
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Install].
  Future<Install> deleteRow(
    _is.DatabaseSession session,
    Install row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Install>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Install>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InstallTable> where,
    _is.OrderByBuilder<InstallTable>? orderBy,
    _is.OrderByListBuilder<InstallTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Install>(
      where: where(Install.t),
      orderBy: orderBy?.call(Install.t),
      orderByList: orderByList?.call(Install.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InstallTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Install>(
      where: where?.call(Install.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Install] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InstallTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Install>(
      where: where(Install.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
