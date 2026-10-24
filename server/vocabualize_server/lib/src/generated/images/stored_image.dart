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

abstract class StoredImage implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StoredImage._({
    this.id,
    required this.authUserId,
    required this.imageId,
    required this.variant,
    required this.byteSize,
    required this.uploadedAt,
  });

  factory StoredImage({
    int? id,
    required _is.UuidValue authUserId,
    required _is.UuidValue imageId,
    required String variant,
    required int byteSize,
    required DateTime uploadedAt,
  }) = _StoredImageImpl;

  factory StoredImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoredImage(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['authUserId']),
      imageId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['imageId']),
      variant: jsonSerialization['variant'] as String,
      byteSize: jsonSerialization['byteSize'] as int,
      uploadedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
    );
  }

  static final t = StoredImageTable();

  static const db = StoredImageRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _is.UuidValue imageId;

  String variant;

  int byteSize;

  DateTime uploadedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoredImage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StoredImage copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _is.UuidValue? imageId,
    String? variant,
    int? byteSize,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoredImage',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'imageId': imageId.toJson(),
      'variant': variant,
      'byteSize': byteSize,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static StoredImageInclude include() {
    return StoredImageInclude._();
  }

  static StoredImageIncludeList includeList({
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    StoredImageInclude? include,
  }) {
    return StoredImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoredImageImpl extends StoredImage {
  _StoredImageImpl({
    int? id,
    required _is.UuidValue authUserId,
    required _is.UuidValue imageId,
    required String variant,
    required int byteSize,
    required DateTime uploadedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         imageId: imageId,
         variant: variant,
         byteSize: byteSize,
         uploadedAt: uploadedAt,
       );

  /// Returns a shallow copy of this [StoredImage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StoredImage copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    _is.UuidValue? imageId,
    String? variant,
    int? byteSize,
    DateTime? uploadedAt,
  }) {
    return StoredImage(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      imageId: imageId ?? this.imageId,
      variant: variant ?? this.variant,
      byteSize: byteSize ?? this.byteSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}

class StoredImageUpdateTable extends _is.UpdateTable<StoredImageTable> {
  StoredImageUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(_is.UuidValue value) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> imageId(_is.UuidValue value) => _is.ColumnValue(
    table.imageId,
    value,
  );

  _is.ColumnValue<String, String> variant(String value) => _is.ColumnValue(
    table.variant,
    value,
  );

  _is.ColumnValue<int, int> byteSize(int value) => _is.ColumnValue(
    table.byteSize,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> uploadedAt(DateTime value) => _is.ColumnValue(
    table.uploadedAt,
    value,
  );
}

class StoredImageTable extends _is.Table<int?> {
  StoredImageTable({super.tableRelation}) : super(tableName: 'stored_image') {
    updateTable = StoredImageUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    imageId = _is.ColumnUuid(
      'imageId',
      this,
    );
    variant = _is.ColumnString(
      'variant',
      this,
    );
    byteSize = _is.ColumnInt(
      'byteSize',
      this,
    );
    uploadedAt = _is.ColumnDateTime(
      'uploadedAt',
      this,
    );
  }

  late final StoredImageUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnUuid imageId;

  late final _is.ColumnString variant;

  late final _is.ColumnInt byteSize;

  late final _is.ColumnDateTime uploadedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    imageId,
    variant,
    byteSize,
    uploadedAt,
  ];
}

class StoredImageInclude extends _is.IncludeObject {
  StoredImageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StoredImage.t;
}

class StoredImageIncludeList extends _is.IncludeList {
  StoredImageIncludeList._({
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoredImage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StoredImage.t;
}

class StoredImageRepository {
  const StoredImageRepository._();

  /// Returns a list of [StoredImage]s matching the given query parameters.
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
  Future<List<StoredImage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoredImage>(
      where: where?.call(StoredImage.t),
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [StoredImage]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `StoredImage.t`.
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
  _ida.Stream<List<StoredImage>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<StoredImage>(
      where: where?.call(StoredImage.t),
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [StoredImage] matching the given query parameters.
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
  Future<StoredImage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    int? offset,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoredImage>(
      where: where?.call(StoredImage.t),
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoredImage] by its [id] or null if no such row exists.
  Future<StoredImage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StoredImage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StoredImage]s in the list and returns the inserted rows.
  ///
  /// The returned [StoredImage]s will have their `id` fields set.
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
  Future<List<StoredImage>> insert(
    _is.DatabaseSession session,
    List<StoredImage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StoredImage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StoredImage] and returns the inserted row.
  ///
  /// The returned [StoredImage] will have its `id` field set.
  Future<StoredImage> insertRow(
    _is.DatabaseSession session,
    StoredImage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoredImage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StoredImage]s in the list and returns the resulting rows.
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
  /// The returned [StoredImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoredImage>> upsert(
    _is.DatabaseSession session,
    List<StoredImage> rows, {
    required _is.ColumnSelections<StoredImageTable> conflictColumns,
    _is.ColumnSelections<StoredImageTable>? updateColumns,
    _is.WhereExpressionBuilder<StoredImageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StoredImage>(
      rows,
      conflictColumns: conflictColumns(StoredImage.t),
      updateColumns: updateColumns?.call(StoredImage.t),
      updateWhere: updateWhere?.call(StoredImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StoredImage] and returns the resulting row.
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
  /// The returned [StoredImage] will have its `id` field set.
  Future<StoredImage?> upsertRow(
    _is.DatabaseSession session,
    StoredImage row, {
    required _is.ColumnSelections<StoredImageTable> conflictColumns,
    _is.ColumnSelections<StoredImageTable>? updateColumns,
    _is.WhereExpressionBuilder<StoredImageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StoredImage>(
      row,
      conflictColumns: conflictColumns(StoredImage.t),
      updateColumns: updateColumns?.call(StoredImage.t),
      updateWhere: updateWhere?.call(StoredImage.t),
      transaction: transaction,
    );
  }

  /// Updates all [StoredImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoredImage>> update(
    _is.DatabaseSession session,
    List<StoredImage> rows, {
    _is.ColumnSelections<StoredImageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StoredImage>(
      rows,
      columns: columns?.call(StoredImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StoredImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoredImage> updateRow(
    _is.DatabaseSession session,
    StoredImage row, {
    _is.ColumnSelections<StoredImageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoredImage>(
      row,
      columns: columns?.call(StoredImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoredImage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoredImage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoredImageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StoredImage>(
      id,
      columnValues: columnValues(StoredImage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoredImage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoredImage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoredImageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StoredImageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StoredImage>(
      columnValues: columnValues(StoredImage.t.updateTable),
      where: where(StoredImage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StoredImage]s in the list and returns the deleted rows.
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
  Future<List<StoredImage>> delete(
    _is.DatabaseSession session,
    List<StoredImage> rows, {
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StoredImage>(
      rows,
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StoredImage].
  Future<StoredImage> deleteRow(
    _is.DatabaseSession session,
    StoredImage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoredImage>(
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
  Future<List<StoredImage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoredImageTable> where,
    _is.OrderByBuilder<StoredImageTable>? orderBy,
    _is.OrderByListBuilder<StoredImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StoredImage>(
      where: where(StoredImage.t),
      orderBy: orderBy?.call(StoredImage.t),
      orderByList: orderByList?.call(StoredImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoredImageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StoredImage>(
      where: where?.call(StoredImage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoredImage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoredImageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoredImage>(
      where: where(StoredImage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
