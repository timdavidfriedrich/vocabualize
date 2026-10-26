/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart'
    as _ipulbpi2;
import 'package:vocabualize_client/src/protocol/ai/remote_stock_image.dart'
    as _i11dp5nn;
import 'package:vocabualize_client/src/protocol/images/remote_image_download.dart'
    as _ixnafqut;
import 'ai/ai_quota_exceeded_exception.dart' as _ituros2n;
import 'ai/ai_unavailable_exception.dart' as _iid9nodj;
import 'ai/remote_stock_image.dart' as _iwo8lv3v;
import 'config/remote_app_config.dart' as _ia9g9wp9;
import 'images/remote_image_download.dart' as _i35otcr0;
import 'reports/remote_report_context.dart' as _ikiv91es;
import 'reports/report_rejected_exception.dart' as _ipfy84dl;
import 'sync/local_activity.dart' as _ilpzzhur;
import 'sync/local_setting.dart' as _ij5ultnt;
import 'sync/local_tag.dart' as _ia93wqla;
import 'sync/local_vocabulary.dart' as _ifmbxptn;
import 'sync/local_vocabulary_tag.dart' as _iagtk9m4;
export 'ai/ai_quota_exceeded_exception.dart';
export 'ai/ai_unavailable_exception.dart';
export 'ai/remote_stock_image.dart';
export 'config/remote_app_config.dart';
export 'images/remote_image_download.dart';
export 'reports/remote_report_context.dart';
export 'reports/report_rejected_exception.dart';
export 'sync/local_activity.dart';
export 'sync/local_setting.dart';
export 'sync/local_tag.dart';
export 'sync/local_vocabulary.dart';
export 'sync/local_vocabulary_tag.dart';
export 'client.dart';
export 'sync_tables.dart';

class Protocol extends _isd.DatabaseSerializationManager
    implements _isd.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _isc.ProtocolDeserialization get deserializationMetadata =>
      _isc.ProtocolDeserialization.cached(
        this,
        types: const [
          _isc.getType<_ituros2n.AiQuotaExceededException>,
          _isc.getType<_iid9nodj.AiUnavailableException>,
          _isc.getType<_iwo8lv3v.RemoteStockImage>,
          _isc.getType<_ia9g9wp9.RemoteAppConfig>,
          _isc.getType<_i35otcr0.RemoteImageDownload>,
          _isc.getType<_ikiv91es.RemoteReportContext>,
          _isc.getType<_ipfy84dl.ReportRejectedException>,
          _isc.getType<_ilpzzhur.LocalActivity>,
          _isc.getType<_ij5ultnt.LocalSetting>,
          _isc.getType<_ia93wqla.LocalTag>,
          _isc.getType<_ifmbxptn.LocalVocabulary>,
          _isc.getType<_iagtk9m4.LocalVocabularyTag>,
          _isc.getType<_ituros2n.AiQuotaExceededException?>,
          _isc.getType<_iid9nodj.AiUnavailableException?>,
          _isc.getType<_iwo8lv3v.RemoteStockImage?>,
          _isc.getType<_ia9g9wp9.RemoteAppConfig?>,
          _isc.getType<_i35otcr0.RemoteImageDownload?>,
          _isc.getType<_ikiv91es.RemoteReportContext?>,
          _isc.getType<_ipfy84dl.ReportRejectedException?>,
          _isc.getType<_ilpzzhur.LocalActivity?>,
          _isc.getType<_ij5ultnt.LocalSetting?>,
          _isc.getType<_ia93wqla.LocalTag?>,
          _isc.getType<_ifmbxptn.LocalVocabulary?>,
          _isc.getType<_iagtk9m4.LocalVocabularyTag?>,
          _isc.getType<List<_i11dp5nn.RemoteStockImage>>,
          _isc.getType<List<String>>,
          _isc.getType<List<_ixnafqut.RemoteImageDownload>>,
        ],
        modules: const [
          _iaic.Protocol.new,
          _ipulbpi2.Protocol.new,
          _iacc.Protocol.new,
        ],
      );

  static List<_isd.TableDefinition> get targetTableDefinitions => [
    _isd.TableDefinition(
      name: 'activity',
      dartName: 'LocalActivity',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'type',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'localDate',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'occurredAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'extras',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'activity_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'activity_local_date_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'localDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'setting',
      dartName: 'LocalSetting',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'key',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'value',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'changedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'extras',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'setting_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'setting_key_changed_at_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'key',
            ),
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'changedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'tag',
      dartName: 'LocalTag',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'name',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'extras',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'tag_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'vocabulary',
      dartName: 'LocalVocabulary',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'source',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'target',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'sourceLanguageCode',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'targetLanguageCode',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'level',
          columnType: _isd.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isd.ColumnDefinition(
          name: 'isNovice',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isd.ColumnDefinition(
          name: 'intervalMinutes',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'ease',
          columnType: _isd.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isd.ColumnDefinition(
          name: 'nextReviewAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'imageKind',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'customImageId',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'customImageUploadedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'stockImageId',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'stockImageUrl',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'stockImageThumbUrl',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'stockPhotographer',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'stockPhotographerUrl',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'extras',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'vocabulary_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'vocabulary_next_review_at_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'nextReviewAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isd.IndexDefinition(
          indexName: 'vocabulary_created_at_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'vocabulary_tag',
      dartName: 'LocalVocabularyTag',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'spaceId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'vocabularyId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'tagId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'extras',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isd.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isd.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_1',
          columns: ['vocabularyId'],
          referenceTable: 'vocabulary',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
          deferrable: _isd.DeferrableConstraint.initiallyDeferred,
        ),
        _isd.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_2',
          columns: ['tagId'],
          referenceTable: 'tag',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isd.ForeignKeyAction.noAction,
          onDelete: _isd.ForeignKeyAction.cascade,
          matchType: null,
          deferrable: _isd.DeferrableConstraint.initiallyDeferred,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    ..._iaic.Protocol() is _isd.DatabaseSerializationManager
        ? (_iaic.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._ipulbpi2.Protocol() is _isd.DatabaseSerializationManager
        ? (_ipulbpi2.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._iacc.Protocol() is _isd.DatabaseSerializationManager
        ? (_iacc.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ituros2n.AiQuotaExceededException) {
      return _ituros2n.AiQuotaExceededException.fromJson(data) as T;
    }
    if (t == _iid9nodj.AiUnavailableException) {
      return _iid9nodj.AiUnavailableException.fromJson(data) as T;
    }
    if (t == _iwo8lv3v.RemoteStockImage) {
      return _iwo8lv3v.RemoteStockImage.fromJson(data) as T;
    }
    if (t == _ia9g9wp9.RemoteAppConfig) {
      return _ia9g9wp9.RemoteAppConfig.fromJson(data) as T;
    }
    if (t == _i35otcr0.RemoteImageDownload) {
      return _i35otcr0.RemoteImageDownload.fromJson(data) as T;
    }
    if (t == _ikiv91es.RemoteReportContext) {
      return _ikiv91es.RemoteReportContext.fromJson(data) as T;
    }
    if (t == _ipfy84dl.ReportRejectedException) {
      return _ipfy84dl.ReportRejectedException.fromJson(data) as T;
    }
    if (t == _ilpzzhur.LocalActivity) {
      return _ilpzzhur.LocalActivity.fromJson(data) as T;
    }
    if (t == _ij5ultnt.LocalSetting) {
      return _ij5ultnt.LocalSetting.fromJson(data) as T;
    }
    if (t == _ia93wqla.LocalTag) {
      return _ia93wqla.LocalTag.fromJson(data) as T;
    }
    if (t == _ifmbxptn.LocalVocabulary) {
      return _ifmbxptn.LocalVocabulary.fromJson(data) as T;
    }
    if (t == _iagtk9m4.LocalVocabularyTag) {
      return _iagtk9m4.LocalVocabularyTag.fromJson(data) as T;
    }
    if (t == _isc.getType<_ituros2n.AiQuotaExceededException?>()) {
      return (data != null
              ? _ituros2n.AiQuotaExceededException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iid9nodj.AiUnavailableException?>()) {
      return (data != null
              ? _iid9nodj.AiUnavailableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iwo8lv3v.RemoteStockImage?>()) {
      return (data != null ? _iwo8lv3v.RemoteStockImage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ia9g9wp9.RemoteAppConfig?>()) {
      return (data != null ? _ia9g9wp9.RemoteAppConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i35otcr0.RemoteImageDownload?>()) {
      return (data != null
              ? _i35otcr0.RemoteImageDownload.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ikiv91es.RemoteReportContext?>()) {
      return (data != null
              ? _ikiv91es.RemoteReportContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipfy84dl.ReportRejectedException?>()) {
      return (data != null
              ? _ipfy84dl.ReportRejectedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilpzzhur.LocalActivity?>()) {
      return (data != null ? _ilpzzhur.LocalActivity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij5ultnt.LocalSetting?>()) {
      return (data != null ? _ij5ultnt.LocalSetting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia93wqla.LocalTag?>()) {
      return (data != null ? _ia93wqla.LocalTag.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifmbxptn.LocalVocabulary?>()) {
      return (data != null ? _ifmbxptn.LocalVocabulary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iagtk9m4.LocalVocabularyTag?>()) {
      return (data != null ? _iagtk9m4.LocalVocabularyTag.fromJson(data) : null)
          as T;
    }
    if (t == List<_i11dp5nn.RemoteStockImage>) {
      return (data as List)
              .map((e) => deserialize<_i11dp5nn.RemoteStockImage>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ixnafqut.RemoteImageDownload>) {
      return (data as List)
              .map((e) => deserialize<_ixnafqut.RemoteImageDownload>(e))
              .toList()
          as T;
    }
    final modules = dataClassName == null
        ? deserializationMetadata.modulesForType(t)
        : deserializationMetadata.modules;
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _isc.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ituros2n.AiQuotaExceededException => 'AiQuotaExceededException',
      _iid9nodj.AiUnavailableException => 'AiUnavailableException',
      _iwo8lv3v.RemoteStockImage => 'RemoteStockImage',
      _ia9g9wp9.RemoteAppConfig => 'RemoteAppConfig',
      _i35otcr0.RemoteImageDownload => 'RemoteImageDownload',
      _ikiv91es.RemoteReportContext => 'RemoteReportContext',
      _ipfy84dl.ReportRejectedException => 'ReportRejectedException',
      _ilpzzhur.LocalActivity => 'LocalActivity',
      _ij5ultnt.LocalSetting => 'LocalSetting',
      _ia93wqla.LocalTag => 'LocalTag',
      _ifmbxptn.LocalVocabulary => 'LocalVocabulary',
      _iagtk9m4.LocalVocabularyTag => 'LocalVocabularyTag',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('vocabualize.', '');
    }

    switch (data) {
      case _ituros2n.AiQuotaExceededException():
        return 'AiQuotaExceededException';
      case _iid9nodj.AiUnavailableException():
        return 'AiUnavailableException';
      case _iwo8lv3v.RemoteStockImage():
        return 'RemoteStockImage';
      case _ia9g9wp9.RemoteAppConfig():
        return 'RemoteAppConfig';
      case _i35otcr0.RemoteImageDownload():
        return 'RemoteImageDownload';
      case _ikiv91es.RemoteReportContext():
        return 'RemoteReportContext';
      case _ipfy84dl.ReportRejectedException():
        return 'ReportRejectedException';
      case _ilpzzhur.LocalActivity():
        return 'LocalActivity';
      case _ij5ultnt.LocalSetting():
        return 'LocalSetting';
      case _ia93wqla.LocalTag():
        return 'LocalTag';
      case _ifmbxptn.LocalVocabulary():
        return 'LocalVocabulary';
      case _iagtk9m4.LocalVocabularyTag():
        return 'LocalVocabularyTag';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _ipulbpi2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_offline_sync.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AiQuotaExceededException') {
      return deserialize<_ituros2n.AiQuotaExceededException>(data['data']);
    }
    if (dataClassName == 'AiUnavailableException') {
      return deserialize<_iid9nodj.AiUnavailableException>(data['data']);
    }
    if (dataClassName == 'RemoteStockImage') {
      return deserialize<_iwo8lv3v.RemoteStockImage>(data['data']);
    }
    if (dataClassName == 'RemoteAppConfig') {
      return deserialize<_ia9g9wp9.RemoteAppConfig>(data['data']);
    }
    if (dataClassName == 'RemoteImageDownload') {
      return deserialize<_i35otcr0.RemoteImageDownload>(data['data']);
    }
    if (dataClassName == 'RemoteReportContext') {
      return deserialize<_ikiv91es.RemoteReportContext>(data['data']);
    }
    if (dataClassName == 'ReportRejectedException') {
      return deserialize<_ipfy84dl.ReportRejectedException>(data['data']);
    }
    if (dataClassName == 'LocalActivity') {
      return deserialize<_ilpzzhur.LocalActivity>(data['data']);
    }
    if (dataClassName == 'LocalSetting') {
      return deserialize<_ij5ultnt.LocalSetting>(data['data']);
    }
    if (dataClassName == 'LocalTag') {
      return deserialize<_ia93wqla.LocalTag>(data['data']);
    }
    if (dataClassName == 'LocalVocabulary') {
      return deserialize<_ifmbxptn.LocalVocabulary>(data['data']);
    }
    if (dataClassName == 'LocalVocabularyTag') {
      return deserialize<_iagtk9m4.LocalVocabularyTag>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_offline_sync.')) {
      data['className'] = dataClassName.substring(23);
      return _ipulbpi2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('vocabualize', this);
    _ipulbpi2.Protocol().registerHostProtocol('vocabualize', this);
    _iacc.Protocol().registerHostProtocol('vocabualize', this);
  }

  @override
  _isd.Table? getTableForType(Type t) {
    {
      var protocol = _iaic.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _ipulbpi2.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _iacc.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ilpzzhur.LocalActivity:
        return _ilpzzhur.LocalActivity.t;
      case _ij5ultnt.LocalSetting:
        return _ij5ultnt.LocalSetting.t;
      case _ia93wqla.LocalTag:
        return _ia93wqla.LocalTag.t;
      case _ifmbxptn.LocalVocabulary:
        return _ifmbxptn.LocalVocabulary.t;
      case _iagtk9m4.LocalVocabularyTag:
        return _iagtk9m4.LocalVocabularyTag.t;
    }
    return null;
  }

  @override
  List<_isd.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'vocabualize';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _ipulbpi2.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
