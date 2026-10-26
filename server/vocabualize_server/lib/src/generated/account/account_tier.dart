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

abstract class AccountTier implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AccountTier._({
    this.id,
    required this.authUserId,
    required this.tier,
    required this.grantedAt,
  });

  factory AccountTier({
    int? id,
    required _is.UuidValue authUserId,
    required String tier,
    required DateTime grantedAt,
  }) = _AccountTierImpl;

  factory AccountTier.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountTier(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['authUserId']),
      tier: jsonSerialization['tier'] as String,
      grantedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['grantedAt']),
    );
  }

  static final t = AccountTierTable();

  static const db = AccountTierRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String tier;

  DateTime grantedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccountTier]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AccountTier copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? tier,
    DateTime? grantedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountTier',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'tier': tier,
      'grantedAt': grantedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AccountTierInclude include() {
    return AccountTierInclude._();
  }

  static AccountTierIncludeList includeList({
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    AccountTierInclude? include,
  }) {
    return AccountTierIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountTierImpl extends AccountTier {
  _AccountTierImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String tier,
    required DateTime grantedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         tier: tier,
         grantedAt: grantedAt,
       );

  /// Returns a shallow copy of this [AccountTier]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AccountTier copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? tier,
    DateTime? grantedAt,
  }) {
    return AccountTier(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      tier: tier ?? this.tier,
      grantedAt: grantedAt ?? this.grantedAt,
    );
  }
}

class AccountTierUpdateTable extends _is.UpdateTable<AccountTierTable> {
  AccountTierUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(_is.UuidValue value) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> tier(String value) => _is.ColumnValue(
    table.tier,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> grantedAt(DateTime value) => _is.ColumnValue(
    table.grantedAt,
    value,
  );
}

class AccountTierTable extends _is.Table<int?> {
  AccountTierTable({super.tableRelation}) : super(tableName: 'account_tier') {
    updateTable = AccountTierUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    tier = _is.ColumnString(
      'tier',
      this,
    );
    grantedAt = _is.ColumnDateTime(
      'grantedAt',
      this,
    );
  }

  late final AccountTierUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString tier;

  late final _is.ColumnDateTime grantedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    tier,
    grantedAt,
  ];
}

class AccountTierInclude extends _is.IncludeObject {
  AccountTierInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AccountTier.t;
}

class AccountTierIncludeList extends _is.IncludeList {
  AccountTierIncludeList._({
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccountTier.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AccountTier.t;
}

class AccountTierRepository {
  const AccountTierRepository._();

  /// Returns a list of [AccountTier]s matching the given query parameters.
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
  Future<List<AccountTier>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccountTier>(
      where: where?.call(AccountTier.t),
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [AccountTier]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `AccountTier.t`.
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
  _ida.Stream<List<AccountTier>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<AccountTier>(
      where: where?.call(AccountTier.t),
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [AccountTier] matching the given query parameters.
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
  Future<AccountTier?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    int? offset,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccountTier>(
      where: where?.call(AccountTier.t),
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccountTier] by its [id] or null if no such row exists.
  Future<AccountTier?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccountTier>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccountTier]s in the list and returns the inserted rows.
  ///
  /// The returned [AccountTier]s will have their `id` fields set.
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
  Future<List<AccountTier>> insert(
    _is.DatabaseSession session,
    List<AccountTier> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AccountTier>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AccountTier] and returns the inserted row.
  ///
  /// The returned [AccountTier] will have its `id` field set.
  Future<AccountTier> insertRow(
    _is.DatabaseSession session,
    AccountTier row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccountTier>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AccountTier]s in the list and returns the resulting rows.
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
  /// The returned [AccountTier]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountTier>> upsert(
    _is.DatabaseSession session,
    List<AccountTier> rows, {
    required _is.ColumnSelections<AccountTierTable> conflictColumns,
    _is.ColumnSelections<AccountTierTable>? updateColumns,
    _is.WhereExpressionBuilder<AccountTierTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AccountTier>(
      rows,
      conflictColumns: conflictColumns(AccountTier.t),
      updateColumns: updateColumns?.call(AccountTier.t),
      updateWhere: updateWhere?.call(AccountTier.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AccountTier] and returns the resulting row.
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
  /// The returned [AccountTier] will have its `id` field set.
  Future<AccountTier?> upsertRow(
    _is.DatabaseSession session,
    AccountTier row, {
    required _is.ColumnSelections<AccountTierTable> conflictColumns,
    _is.ColumnSelections<AccountTierTable>? updateColumns,
    _is.WhereExpressionBuilder<AccountTierTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AccountTier>(
      row,
      conflictColumns: conflictColumns(AccountTier.t),
      updateColumns: updateColumns?.call(AccountTier.t),
      updateWhere: updateWhere?.call(AccountTier.t),
      transaction: transaction,
    );
  }

  /// Updates all [AccountTier]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountTier>> update(
    _is.DatabaseSession session,
    List<AccountTier> rows, {
    _is.ColumnSelections<AccountTierTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AccountTier>(
      rows,
      columns: columns?.call(AccountTier.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AccountTier]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccountTier> updateRow(
    _is.DatabaseSession session,
    AccountTier row, {
    _is.ColumnSelections<AccountTierTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccountTier>(
      row,
      columns: columns?.call(AccountTier.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccountTier] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccountTier?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AccountTierUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AccountTier>(
      id,
      columnValues: columnValues(AccountTier.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccountTier]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountTier>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AccountTierUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AccountTierTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AccountTier>(
      columnValues: columnValues(AccountTier.t.updateTable),
      where: where(AccountTier.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AccountTier]s in the list and returns the deleted rows.
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
  Future<List<AccountTier>> delete(
    _is.DatabaseSession session,
    List<AccountTier> rows, {
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AccountTier>(
      rows,
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AccountTier].
  Future<AccountTier> deleteRow(
    _is.DatabaseSession session,
    AccountTier row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccountTier>(
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
  Future<List<AccountTier>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AccountTierTable> where,
    _is.OrderByBuilder<AccountTierTable>? orderBy,
    _is.OrderByListBuilder<AccountTierTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AccountTier>(
      where: where(AccountTier.t),
      orderBy: orderBy?.call(AccountTier.t),
      orderByList: orderByList?.call(AccountTier.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AccountTierTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AccountTier>(
      where: where?.call(AccountTier.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccountTier] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AccountTierTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccountTier>(
      where: where(AccountTier.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
