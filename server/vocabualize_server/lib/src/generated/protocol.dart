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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart' as _iais;
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart' as _izehhkf5;
import 'package:vocabualize_server/src/generated/images/remote_image_download.dart' as _ixx56s9r;
import 'config/image_storage_config.dart' as _il54hkej;
import 'config/remote_app_config.dart' as _ia9g9wp9;
import 'config/runtime_config.dart' as _iadewe5j;
import 'images/remote_image_download.dart' as _i35otcr0;
import 'images/stored_image.dart' as _i3kglx6m;
import 'sync/local_activity.dart' as _ilpzzhur;
import 'sync/local_tag.dart' as _ia93wqla;
import 'sync/local_vocabulary.dart' as _ifmbxptn;
import 'sync/local_vocabulary_tag.dart' as _iagtk9m4;
export 'config/image_storage_config.dart';
export 'config/remote_app_config.dart';
export 'config/runtime_config.dart';
export 'images/remote_image_download.dart';
export 'images/stored_image.dart';
export 'sync/local_activity.dart';
export 'sync/local_tag.dart';
export 'sync/local_vocabulary.dart';
export 'sync/local_vocabulary_tag.dart';
export 'sync_tables.dart';

class Protocol extends _is.DatabaseSerializationManager
    implements _is.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _is.ProtocolDeserialization get deserializationMetadata => _is.ProtocolDeserialization.cached(
    this,
    types: const [
      _is.getType<_il54hkej.ImageStorageConfig>,
      _is.getType<_ia9g9wp9.RemoteAppConfig>,
      _is.getType<_iadewe5j.RuntimeConfig>,
      _is.getType<_i35otcr0.RemoteImageDownload>,
      _is.getType<_i3kglx6m.StoredImage>,
      _is.getType<_ilpzzhur.LocalActivity>,
      _is.getType<_ia93wqla.LocalTag>,
      _is.getType<_ifmbxptn.LocalVocabulary>,
      _is.getType<_iagtk9m4.LocalVocabularyTag>,
      _is.getType<_il54hkej.ImageStorageConfig?>,
      _is.getType<_ia9g9wp9.RemoteAppConfig?>,
      _is.getType<_iadewe5j.RuntimeConfig?>,
      _is.getType<_i35otcr0.RemoteImageDownload?>,
      _is.getType<_i3kglx6m.StoredImage?>,
      _is.getType<_ilpzzhur.LocalActivity?>,
      _is.getType<_ia93wqla.LocalTag?>,
      _is.getType<_ifmbxptn.LocalVocabulary?>,
      _is.getType<_iagtk9m4.LocalVocabularyTag?>,
      _is.getType<List<String>>,
      _is.getType<List<_ixx56s9r.RemoteImageDownload>>,
    ],
    modules: const [
      _iais.Protocol.new,
      _izehhkf5.Protocol.new,
      _iacs.Protocol.new,
      _isp.Protocol.new,
    ],
  );

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'activity',
      dartName: 'LocalActivity',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'localDate',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'occurredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'extras',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'activity_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'activity_local_date_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'stored_image',
      dartName: 'StoredImage',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'imageId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'variant',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'byteSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'uploadedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'stored_image_owner_image_variant_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'imageId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'variant',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'tag',
      dartName: 'LocalTag',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'extras',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'tag_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vocabulary',
      dartName: 'LocalVocabulary',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'target',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceLanguageCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetLanguageCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'isNovice',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'intervalMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'ease',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'nextReviewAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'imageKind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'customImageId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'customImageUploadedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'stockImageId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'stockImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'stockImageThumbUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'stockPhotographer',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'stockPhotographerUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'extras',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'vocabulary_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'vocabulary_next_review_at_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'nextReviewAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'vocabulary_created_at_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'vocabulary_tag',
      dartName: 'LocalVocabularyTag',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'spaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'vocabularyId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'tagId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'extras',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_0',
          columns: ['spaceId'],
          referenceTable: 'offline_sync_spaces',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_1',
          columns: ['vocabularyId'],
          referenceTable: 'vocabulary',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
          deferrable: _isp.DeferrableConstraint.initiallyDeferred,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'vocabulary_tag_fk_2',
          columns: ['tagId'],
          referenceTable: 'tag',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
          deferrable: _isp.DeferrableConstraint.initiallyDeferred,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._izehhkf5.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _il54hkej.ImageStorageConfig) {
      return _il54hkej.ImageStorageConfig.fromJson(data) as T;
    }
    if (t == _ia9g9wp9.RemoteAppConfig) {
      return _ia9g9wp9.RemoteAppConfig.fromJson(data) as T;
    }
    if (t == _iadewe5j.RuntimeConfig) {
      return _iadewe5j.RuntimeConfig.fromJson(data) as T;
    }
    if (t == _i35otcr0.RemoteImageDownload) {
      return _i35otcr0.RemoteImageDownload.fromJson(data) as T;
    }
    if (t == _i3kglx6m.StoredImage) {
      return _i3kglx6m.StoredImage.fromJson(data) as T;
    }
    if (t == _ilpzzhur.LocalActivity) {
      return _ilpzzhur.LocalActivity.fromJson(data) as T;
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
    if (t == _is.getType<_il54hkej.ImageStorageConfig?>()) {
      return (data != null ? _il54hkej.ImageStorageConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia9g9wp9.RemoteAppConfig?>()) {
      return (data != null ? _ia9g9wp9.RemoteAppConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iadewe5j.RuntimeConfig?>()) {
      return (data != null ? _iadewe5j.RuntimeConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i35otcr0.RemoteImageDownload?>()) {
      return (data != null ? _i35otcr0.RemoteImageDownload.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3kglx6m.StoredImage?>()) {
      return (data != null ? _i3kglx6m.StoredImage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilpzzhur.LocalActivity?>()) {
      return (data != null ? _ilpzzhur.LocalActivity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia93wqla.LocalTag?>()) {
      return (data != null ? _ia93wqla.LocalTag.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifmbxptn.LocalVocabulary?>()) {
      return (data != null ? _ifmbxptn.LocalVocabulary.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iagtk9m4.LocalVocabularyTag?>()) {
      return (data != null ? _iagtk9m4.LocalVocabularyTag.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ixx56s9r.RemoteImageDownload>) {
      return (data as List).map((e) => deserialize<_ixx56s9r.RemoteImageDownload>(e)).toList() as T;
    }
    final modules = dataClassName == null
        ? deserializationMetadata.modulesForType(t)
        : deserializationMetadata.modules;
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _is.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _il54hkej.ImageStorageConfig => 'ImageStorageConfig',
      _ia9g9wp9.RemoteAppConfig => 'RemoteAppConfig',
      _iadewe5j.RuntimeConfig => 'RuntimeConfig',
      _i35otcr0.RemoteImageDownload => 'RemoteImageDownload',
      _i3kglx6m.StoredImage => 'StoredImage',
      _ilpzzhur.LocalActivity => 'LocalActivity',
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
      case _il54hkej.ImageStorageConfig():
        return 'ImageStorageConfig';
      case _ia9g9wp9.RemoteAppConfig():
        return 'RemoteAppConfig';
      case _iadewe5j.RuntimeConfig():
        return 'RuntimeConfig';
      case _i35otcr0.RemoteImageDownload():
        return 'RemoteImageDownload';
      case _i3kglx6m.StoredImage():
        return 'StoredImage';
      case _ilpzzhur.LocalActivity():
        return 'LocalActivity';
      case _ia93wqla.LocalTag():
        return 'LocalTag';
      case _ifmbxptn.LocalVocabulary():
        return 'LocalVocabulary';
      case _iagtk9m4.LocalVocabularyTag():
        return 'LocalVocabularyTag';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth_idp.$className';
    }
    className = _izehhkf5.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_offline_sync.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ImageStorageConfig') {
      return deserialize<_il54hkej.ImageStorageConfig>(data['data']);
    }
    if (dataClassName == 'RemoteAppConfig') {
      return deserialize<_ia9g9wp9.RemoteAppConfig>(data['data']);
    }
    if (dataClassName == 'RuntimeConfig') {
      return deserialize<_iadewe5j.RuntimeConfig>(data['data']);
    }
    if (dataClassName == 'RemoteImageDownload') {
      return deserialize<_i35otcr0.RemoteImageDownload>(data['data']);
    }
    if (dataClassName == 'StoredImage') {
      return deserialize<_i3kglx6m.StoredImage>(data['data']);
    }
    if (dataClassName == 'LocalActivity') {
      return deserialize<_ilpzzhur.LocalActivity>(data['data']);
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_offline_sync.')) {
      data['className'] = dataClassName.substring(23);
      return _izehhkf5.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('vocabualize', this);
    _izehhkf5.Protocol().registerHostProtocol('vocabualize', this);
    _iacs.Protocol().registerHostProtocol('vocabualize', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _izehhkf5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i3kglx6m.StoredImage:
        return _i3kglx6m.StoredImage.t;
      case _ilpzzhur.LocalActivity:
        return _ilpzzhur.LocalActivity.t;
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
  List<_isp.TableDefinition> getTargetTableDefinitions() => targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _izehhkf5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
