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

abstract class ServiceUsage implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ServiceUsage._({
    this.id,
    required this.ownerId,
    required this.kind,
    required this.status,
    required this.createdAt,
  });

  factory ServiceUsage({
    int? id,
    required _is.UuidValue ownerId,
    required String kind,
    required String status,
    required DateTime createdAt,
  }) = _ServiceUsageImpl;

  factory ServiceUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceUsage(
      id: jsonSerialization['id'] as int?,
      ownerId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['ownerId']),
      kind: jsonSerialization['kind'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ServiceUsageTable();

  static const db = ServiceUsageRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

  String kind;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ServiceUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ServiceUsage copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? kind,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceUsage',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'kind': kind,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ServiceUsageInclude include() {
    return ServiceUsageInclude._();
  }

  static ServiceUsageIncludeList includeList({
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    ServiceUsageInclude? include,
  }) {
    return ServiceUsageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceUsageImpl extends ServiceUsage {
  _ServiceUsageImpl({
    int? id,
    required _is.UuidValue ownerId,
    required String kind,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         kind: kind,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ServiceUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ServiceUsage copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    String? kind,
    String? status,
    DateTime? createdAt,
  }) {
    return ServiceUsage(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ServiceUsageUpdateTable extends _is.UpdateTable<ServiceUsageTable> {
  ServiceUsageUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) => _is.ColumnValue(
    table.ownerId,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) => _is.ColumnValue(
    table.createdAt,
    value,
  );
}

class ServiceUsageTable extends _is.Table<int?> {
  ServiceUsageTable({super.tableRelation}) : super(tableName: 'service_usage') {
    updateTable = ServiceUsageUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ServiceUsageUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString kind;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    kind,
    status,
    createdAt,
  ];
}

class ServiceUsageInclude extends _is.IncludeObject {
  ServiceUsageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ServiceUsage.t;
}

class ServiceUsageIncludeList extends _is.IncludeList {
  ServiceUsageIncludeList._({
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ServiceUsage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ServiceUsage.t;
}

class ServiceUsageRepository {
  const ServiceUsageRepository._();

  /// Returns a list of [ServiceUsage]s matching the given query parameters.
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
  Future<List<ServiceUsage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ServiceUsage>(
      where: where?.call(ServiceUsage.t),
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ServiceUsage]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `ServiceUsage.t`.
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
  _ida.Stream<List<ServiceUsage>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ServiceUsage>(
      where: where?.call(ServiceUsage.t),
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ServiceUsage] matching the given query parameters.
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
  Future<ServiceUsage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    int? offset,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ServiceUsage>(
      where: where?.call(ServiceUsage.t),
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ServiceUsage] by its [id] or null if no such row exists.
  Future<ServiceUsage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ServiceUsage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ServiceUsage]s in the list and returns the inserted rows.
  ///
  /// The returned [ServiceUsage]s will have their `id` fields set.
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
  Future<List<ServiceUsage>> insert(
    _is.DatabaseSession session,
    List<ServiceUsage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ServiceUsage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ServiceUsage] and returns the inserted row.
  ///
  /// The returned [ServiceUsage] will have its `id` field set.
  Future<ServiceUsage> insertRow(
    _is.DatabaseSession session,
    ServiceUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ServiceUsage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ServiceUsage]s in the list and returns the resulting rows.
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
  /// The returned [ServiceUsage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ServiceUsage>> upsert(
    _is.DatabaseSession session,
    List<ServiceUsage> rows, {
    required _is.ColumnSelections<ServiceUsageTable> conflictColumns,
    _is.ColumnSelections<ServiceUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<ServiceUsageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ServiceUsage>(
      rows,
      conflictColumns: conflictColumns(ServiceUsage.t),
      updateColumns: updateColumns?.call(ServiceUsage.t),
      updateWhere: updateWhere?.call(ServiceUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ServiceUsage] and returns the resulting row.
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
  /// The returned [ServiceUsage] will have its `id` field set.
  Future<ServiceUsage?> upsertRow(
    _is.DatabaseSession session,
    ServiceUsage row, {
    required _is.ColumnSelections<ServiceUsageTable> conflictColumns,
    _is.ColumnSelections<ServiceUsageTable>? updateColumns,
    _is.WhereExpressionBuilder<ServiceUsageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ServiceUsage>(
      row,
      conflictColumns: conflictColumns(ServiceUsage.t),
      updateColumns: updateColumns?.call(ServiceUsage.t),
      updateWhere: updateWhere?.call(ServiceUsage.t),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceUsage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ServiceUsage>> update(
    _is.DatabaseSession session,
    List<ServiceUsage> rows, {
    _is.ColumnSelections<ServiceUsageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ServiceUsage>(
      rows,
      columns: columns?.call(ServiceUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ServiceUsage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ServiceUsage> updateRow(
    _is.DatabaseSession session,
    ServiceUsage row, {
    _is.ColumnSelections<ServiceUsageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ServiceUsage>(
      row,
      columns: columns?.call(ServiceUsage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceUsage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ServiceUsage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ServiceUsageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ServiceUsage>(
      id,
      columnValues: columnValues(ServiceUsage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceUsage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ServiceUsage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ServiceUsageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ServiceUsageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ServiceUsage>(
      columnValues: columnValues(ServiceUsage.t.updateTable),
      where: where(ServiceUsage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ServiceUsage]s in the list and returns the deleted rows.
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
  Future<List<ServiceUsage>> delete(
    _is.DatabaseSession session,
    List<ServiceUsage> rows, {
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ServiceUsage>(
      rows,
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ServiceUsage].
  Future<ServiceUsage> deleteRow(
    _is.DatabaseSession session,
    ServiceUsage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ServiceUsage>(
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
  Future<List<ServiceUsage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ServiceUsageTable> where,
    _is.OrderByBuilder<ServiceUsageTable>? orderBy,
    _is.OrderByListBuilder<ServiceUsageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ServiceUsage>(
      where: where(ServiceUsage.t),
      orderBy: orderBy?.call(ServiceUsage.t),
      orderByList: orderByList?.call(ServiceUsage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ServiceUsageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ServiceUsage>(
      where: where?.call(ServiceUsage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ServiceUsage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ServiceUsageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ServiceUsage>(
      where: where(ServiceUsage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
