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

abstract class LocalSetting implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  LocalSetting._({
    this.id,
    this.spaceId,
    required this.key,
    required this.value,
    required this.changedAt,
    this.extras,
  });

  factory LocalSetting({
    _is.UuidValue? id,
    int? spaceId,
    required String key,
    required String value,
    required DateTime changedAt,
    String? extras,
  }) = _LocalSettingImpl;

  factory LocalSetting.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalSetting(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      spaceId: jsonSerialization['spaceId'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      changedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['changedAt']),
      extras: jsonSerialization['extras'] as String?,
    );
  }

  static final t = LocalSettingTable();

  static const db = LocalSettingRepository._();

  @override
  _is.UuidValue? id;

  /// The space owning this row. Maintained by the sync engine.
  int? spaceId;

  String key;

  String value;

  DateTime changedAt;

  String? extras;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [LocalSetting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LocalSetting copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    int? spaceId,
    String? key,
    String? value,
    DateTime? changedAt,
    String? extras,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalSetting',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'key': key,
      'value': value,
      'changedAt': changedAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalSetting',
      if (id != null) 'id': id?.toJson(),
      if (spaceId != null) 'spaceId': spaceId,
      'key': key,
      'value': value,
      'changedAt': changedAt.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  static LocalSettingInclude include() {
    return LocalSettingInclude._();
  }

  static LocalSettingIncludeList includeList({
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    LocalSettingInclude? include,
  }) {
    return LocalSettingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalSettingImpl extends LocalSetting {
  _LocalSettingImpl({
    _is.UuidValue? id,
    int? spaceId,
    required String key,
    required String value,
    required DateTime changedAt,
    String? extras,
  }) : super._(
         id: id,
         spaceId: spaceId,
         key: key,
         value: value,
         changedAt: changedAt,
         extras: extras,
       );

  /// Returns a shallow copy of this [LocalSetting]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LocalSetting copyWith({
    _is.UuidValue? id = const _is.$UndefinedUuidValue(),
    Object? spaceId = _Undefined,
    String? key,
    String? value,
    DateTime? changedAt,
    Object? extras = _Undefined,
  }) {
    return LocalSetting(
      id: id is _is.UndefinedSentinel ? this.id : id,
      spaceId: spaceId is int? ? spaceId : this.spaceId,
      key: key ?? this.key,
      value: value ?? this.value,
      changedAt: changedAt ?? this.changedAt,
      extras: extras is String? ? extras : this.extras,
    );
  }
}

class LocalSettingUpdateTable extends _is.UpdateTable<LocalSettingTable> {
  LocalSettingUpdateTable(super.table);

  _is.ColumnValue<int, int> spaceId(int? value) => _is.ColumnValue(
    table.spaceId,
    value,
  );

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<String, String> value(String value) => _is.ColumnValue(
    table.value,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> changedAt(DateTime value) => _is.ColumnValue(
    table.changedAt,
    value,
  );

  _is.ColumnValue<String, String> extras(String? value) => _is.ColumnValue(
    table.extras,
    value,
  );
}

class LocalSettingTable extends _is.Table<_is.UuidValue?> {
  LocalSettingTable({super.tableRelation}) : super(tableName: 'setting') {
    updateTable = LocalSettingUpdateTable(this);
    spaceId = _is.ColumnInt(
      'spaceId',
      this,
    );
    key = _is.ColumnString(
      'key',
      this,
    );
    value = _is.ColumnString(
      'value',
      this,
    );
    changedAt = _is.ColumnDateTime(
      'changedAt',
      this,
    );
    extras = _is.ColumnString(
      'extras',
      this,
    );
  }

  late final LocalSettingUpdateTable updateTable;

  /// The space owning this row. Maintained by the sync engine.
  late final _is.ColumnInt spaceId;

  late final _is.ColumnString key;

  late final _is.ColumnString value;

  late final _is.ColumnDateTime changedAt;

  late final _is.ColumnString extras;

  @override
  List<_is.Column> get columns => [
    id,
    spaceId,
    key,
    value,
    changedAt,
    extras,
  ];
}

class LocalSettingInclude extends _is.IncludeObject {
  LocalSettingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => LocalSetting.t;
}

class LocalSettingIncludeList extends _is.IncludeList {
  LocalSettingIncludeList._({
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocalSetting.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => LocalSetting.t;
}

class LocalSettingRepository {
  const LocalSettingRepository._();

  /// Returns a list of [LocalSetting]s matching the given query parameters.
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
  Future<List<LocalSetting>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocalSetting>(
      where: where?.call(LocalSetting.t),
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [LocalSetting]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `LocalSetting.t`.
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
  _ida.Stream<List<LocalSetting>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<LocalSetting>(
      where: where?.call(LocalSetting.t),
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [LocalSetting] matching the given query parameters.
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
  Future<LocalSetting?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    int? offset,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocalSetting>(
      where: where?.call(LocalSetting.t),
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocalSetting] by its [id] or null if no such row exists.
  Future<LocalSetting?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocalSetting>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocalSetting]s in the list and returns the inserted rows.
  ///
  /// The returned [LocalSetting]s will have their `id` fields set.
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
  Future<List<LocalSetting>> insert(
    _is.DatabaseSession session,
    List<LocalSetting> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LocalSetting>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LocalSetting] and returns the inserted row.
  ///
  /// The returned [LocalSetting] will have its `id` field set.
  Future<LocalSetting> insertRow(
    _is.DatabaseSession session,
    LocalSetting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocalSetting>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LocalSetting]s in the list and returns the resulting rows.
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
  /// The returned [LocalSetting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalSetting>> upsert(
    _is.DatabaseSession session,
    List<LocalSetting> rows, {
    required _is.ColumnSelections<LocalSettingTable> conflictColumns,
    _is.ColumnSelections<LocalSettingTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalSettingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LocalSetting>(
      rows,
      conflictColumns: conflictColumns(LocalSetting.t),
      updateColumns: updateColumns?.call(LocalSetting.t),
      updateWhere: updateWhere?.call(LocalSetting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LocalSetting] and returns the resulting row.
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
  /// The returned [LocalSetting] will have its `id` field set.
  Future<LocalSetting?> upsertRow(
    _is.DatabaseSession session,
    LocalSetting row, {
    required _is.ColumnSelections<LocalSettingTable> conflictColumns,
    _is.ColumnSelections<LocalSettingTable>? updateColumns,
    _is.WhereExpressionBuilder<LocalSettingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LocalSetting>(
      row,
      conflictColumns: conflictColumns(LocalSetting.t),
      updateColumns: updateColumns?.call(LocalSetting.t),
      updateWhere: updateWhere?.call(LocalSetting.t),
      transaction: transaction,
    );
  }

  /// Updates all [LocalSetting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalSetting>> update(
    _is.DatabaseSession session,
    List<LocalSetting> rows, {
    _is.ColumnSelections<LocalSettingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LocalSetting>(
      rows,
      columns: columns?.call(LocalSetting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LocalSetting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocalSetting> updateRow(
    _is.DatabaseSession session,
    LocalSetting row, {
    _is.ColumnSelections<LocalSettingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocalSetting>(
      row,
      columns: columns?.call(LocalSetting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocalSetting] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocalSetting?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<LocalSettingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LocalSetting>(
      id,
      columnValues: columnValues(LocalSetting.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocalSetting]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LocalSetting>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LocalSettingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LocalSettingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LocalSetting>(
      columnValues: columnValues(LocalSetting.t.updateTable),
      where: where(LocalSetting.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LocalSetting]s in the list and returns the deleted rows.
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
  Future<List<LocalSetting>> delete(
    _is.DatabaseSession session,
    List<LocalSetting> rows, {
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LocalSetting>(
      rows,
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LocalSetting].
  Future<LocalSetting> deleteRow(
    _is.DatabaseSession session,
    LocalSetting row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocalSetting>(
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
  Future<List<LocalSetting>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalSettingTable> where,
    _is.OrderByBuilder<LocalSettingTable>? orderBy,
    _is.OrderByListBuilder<LocalSettingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LocalSetting>(
      where: where(LocalSetting.t),
      orderBy: orderBy?.call(LocalSetting.t),
      orderByList: orderByList?.call(LocalSetting.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LocalSettingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LocalSetting>(
      where: where?.call(LocalSetting.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocalSetting] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LocalSettingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocalSetting>(
      where: where(LocalSetting.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
