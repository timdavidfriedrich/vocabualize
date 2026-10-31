import 'package:serverpod_database/serverpod_database.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';

const _spaceIdColumnName = "spaceId";

extension TableExtensions on Table<UuidValue?> {
  Expression<dynamic> get isVisible {
    final row = CrdtDataRow.t;
    final schemaTable = CrdtSchemaTable.t;
    final spaceId = columns.firstWhere((column) => column.columnName == _spaceIdColumnName);
    return Expression(
      "NOT EXISTS (SELECT 1 FROM \"${row.tableName}\" "
      "WHERE ${row.spaceId} = $spaceId "
      "AND ${row.tblId} = (SELECT ${schemaTable.id} FROM \"${schemaTable.tableName}\" "
      "WHERE ${schemaTable.name} = '$tableName') "
      "AND ${row.uuidRowId} = $id "
      "AND ${row.visibility} > $crdtRowLastVisibleVisibilityIndex)",
    );
  }
}
