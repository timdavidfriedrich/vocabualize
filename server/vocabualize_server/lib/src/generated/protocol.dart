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
import 'package:vocabualize_server/src/generated/services/remote_stock_image.dart' as _i7l2n366;
import 'account/account_tier.dart' as _i9kbx4z0;
import 'config/image_labeling_config.dart' as _itqfnsgf;
import 'config/image_storage_config.dart' as _il54hkej;
import 'config/installs_config.dart' as _i7ei07da;
import 'config/remote_app_config.dart' as _ia9g9wp9;
import 'config/reports_config.dart' as _ifa12ii1;
import 'config/runtime_config.dart' as _iadewe5j;
import 'config/stock_images_config.dart' as _i461qwm6;
import 'config/tier_config.dart' as _i4dwxpi4;
import 'config/tiers_config.dart' as _irne63bc;
import 'config/translation_config.dart' as _ialc7yx3;
import 'images/remote_image_download.dart' as _i35otcr0;
import 'images/stored_image.dart' as _i3kglx6m;
import 'installs/install.dart' as _iz2qjf27;
import 'installs/install_rejected_exception.dart' as _istbflf6;
import 'installs/remote_install_key.dart' as _iln4p86h;
import 'reports/remote_report_context.dart' as _ikiv91es;
import 'reports/report.dart' as _ihpzd5k3;
import 'reports/report_rejected_exception.dart' as _ipfy84dl;
import 'services/quota_exceeded_exception.dart' as _iu27gnfp;
import 'services/remote_stock_image.dart' as _i04ejohi;
import 'services/service_unavailable_exception.dart' as _ilti7uc9;
import 'services/service_usage.dart' as _ip1otjwk;
import 'sync/local_activity.dart' as _ilpzzhur;
import 'sync/local_setting.dart' as _ij5ultnt;
import 'sync/local_tag.dart' as _ia93wqla;
import 'sync/local_vocabulary.dart' as _ifmbxptn;
import 'sync/local_vocabulary_tag.dart' as _iagtk9m4;
export 'account/account_tier.dart';
export 'config/image_labeling_config.dart';
export 'config/image_storage_config.dart';
export 'config/installs_config.dart';
export 'config/remote_app_config.dart';
export 'config/reports_config.dart';
export 'config/runtime_config.dart';
export 'config/stock_images_config.dart';
export 'config/tier_config.dart';
export 'config/tiers_config.dart';
export 'config/translation_config.dart';
export 'images/remote_image_download.dart';
export 'images/stored_image.dart';
export 'installs/install.dart';
export 'installs/install_rejected_exception.dart';
export 'installs/remote_install_key.dart';
export 'reports/remote_report_context.dart';
export 'reports/report.dart';
export 'reports/report_rejected_exception.dart';
export 'services/quota_exceeded_exception.dart';
export 'services/remote_stock_image.dart';
export 'services/service_unavailable_exception.dart';
export 'services/service_usage.dart';
export 'sync/local_activity.dart';
export 'sync/local_setting.dart';
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
      _is.getType<_i9kbx4z0.AccountTier>,
      _is.getType<_itqfnsgf.ImageLabelingConfig>,
      _is.getType<_il54hkej.ImageStorageConfig>,
      _is.getType<_i7ei07da.InstallsConfig>,
      _is.getType<_ia9g9wp9.RemoteAppConfig>,
      _is.getType<_ifa12ii1.ReportsConfig>,
      _is.getType<_iadewe5j.RuntimeConfig>,
      _is.getType<_i461qwm6.StockImagesConfig>,
      _is.getType<_i4dwxpi4.TierConfig>,
      _is.getType<_irne63bc.TiersConfig>,
      _is.getType<_ialc7yx3.TranslationConfig>,
      _is.getType<_i35otcr0.RemoteImageDownload>,
      _is.getType<_i3kglx6m.StoredImage>,
      _is.getType<_iz2qjf27.Install>,
      _is.getType<_istbflf6.InstallRejectedException>,
      _is.getType<_iln4p86h.RemoteInstallKey>,
      _is.getType<_ikiv91es.RemoteReportContext>,
      _is.getType<_ihpzd5k3.Report>,
      _is.getType<_ipfy84dl.ReportRejectedException>,
      _is.getType<_iu27gnfp.QuotaExceededException>,
      _is.getType<_i04ejohi.RemoteStockImage>,
      _is.getType<_ilti7uc9.ServiceUnavailableException>,
      _is.getType<_ip1otjwk.ServiceUsage>,
      _is.getType<_ilpzzhur.LocalActivity>,
      _is.getType<_ij5ultnt.LocalSetting>,
      _is.getType<_ia93wqla.LocalTag>,
      _is.getType<_ifmbxptn.LocalVocabulary>,
      _is.getType<_iagtk9m4.LocalVocabularyTag>,
      _is.getType<_i9kbx4z0.AccountTier?>,
      _is.getType<_itqfnsgf.ImageLabelingConfig?>,
      _is.getType<_il54hkej.ImageStorageConfig?>,
      _is.getType<_i7ei07da.InstallsConfig?>,
      _is.getType<_ia9g9wp9.RemoteAppConfig?>,
      _is.getType<_ifa12ii1.ReportsConfig?>,
      _is.getType<_iadewe5j.RuntimeConfig?>,
      _is.getType<_i461qwm6.StockImagesConfig?>,
      _is.getType<_i4dwxpi4.TierConfig?>,
      _is.getType<_irne63bc.TiersConfig?>,
      _is.getType<_ialc7yx3.TranslationConfig?>,
      _is.getType<_i35otcr0.RemoteImageDownload?>,
      _is.getType<_i3kglx6m.StoredImage?>,
      _is.getType<_iz2qjf27.Install?>,
      _is.getType<_istbflf6.InstallRejectedException?>,
      _is.getType<_iln4p86h.RemoteInstallKey?>,
      _is.getType<_ikiv91es.RemoteReportContext?>,
      _is.getType<_ihpzd5k3.Report?>,
      _is.getType<_ipfy84dl.ReportRejectedException?>,
      _is.getType<_iu27gnfp.QuotaExceededException?>,
      _is.getType<_i04ejohi.RemoteStockImage?>,
      _is.getType<_ilti7uc9.ServiceUnavailableException?>,
      _is.getType<_ip1otjwk.ServiceUsage?>,
      _is.getType<_ilpzzhur.LocalActivity?>,
      _is.getType<_ij5ultnt.LocalSetting?>,
      _is.getType<_ia93wqla.LocalTag?>,
      _is.getType<_ifmbxptn.LocalVocabulary?>,
      _is.getType<_iagtk9m4.LocalVocabularyTag?>,
      _is.getType<List<String>>,
      _is.getType<List<_ixx56s9r.RemoteImageDownload>>,
      _is.getType<List<_i7l2n366.RemoteStockImage>>,
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
      name: 'account_tier',
      dartName: 'AccountTier',
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
          name: 'tier',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'grantedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'account_tier_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
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
      name: 'install',
      dartName: 'Install',
      schema: 'public',
      module: 'vocabualize',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random',
        ),
        _isp.ColumnDefinition(
          name: 'secretHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ipHash',
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
          name: 'lastUsedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'install_ip_hash_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ipHash',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'install_created_idx',
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
      name: 'report',
      dartName: 'Report',
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
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'target',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceLanguage',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'targetLanguage',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'appVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'platform',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'appLanguage',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'languagePair',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'ipHash',
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
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'report_ip_hash_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ipHash',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'report_created_idx',
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
      name: 'service_usage',
      dartName: 'ServiceUsage',
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
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
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
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'service_usage_owner_kind_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'kind',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'service_usage_kind_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'kind',
            ),
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
      name: 'setting',
      dartName: 'LocalSetting',
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
          name: 'key',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'value',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'changedAt',
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
          constraintName: 'setting_fk_0',
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
          indexName: 'setting_key_changed_at_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'key',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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

    if (t == _i9kbx4z0.AccountTier) {
      return _i9kbx4z0.AccountTier.fromJson(data) as T;
    }
    if (t == _itqfnsgf.ImageLabelingConfig) {
      return _itqfnsgf.ImageLabelingConfig.fromJson(data) as T;
    }
    if (t == _il54hkej.ImageStorageConfig) {
      return _il54hkej.ImageStorageConfig.fromJson(data) as T;
    }
    if (t == _i7ei07da.InstallsConfig) {
      return _i7ei07da.InstallsConfig.fromJson(data) as T;
    }
    if (t == _ia9g9wp9.RemoteAppConfig) {
      return _ia9g9wp9.RemoteAppConfig.fromJson(data) as T;
    }
    if (t == _ifa12ii1.ReportsConfig) {
      return _ifa12ii1.ReportsConfig.fromJson(data) as T;
    }
    if (t == _iadewe5j.RuntimeConfig) {
      return _iadewe5j.RuntimeConfig.fromJson(data) as T;
    }
    if (t == _i461qwm6.StockImagesConfig) {
      return _i461qwm6.StockImagesConfig.fromJson(data) as T;
    }
    if (t == _i4dwxpi4.TierConfig) {
      return _i4dwxpi4.TierConfig.fromJson(data) as T;
    }
    if (t == _irne63bc.TiersConfig) {
      return _irne63bc.TiersConfig.fromJson(data) as T;
    }
    if (t == _ialc7yx3.TranslationConfig) {
      return _ialc7yx3.TranslationConfig.fromJson(data) as T;
    }
    if (t == _i35otcr0.RemoteImageDownload) {
      return _i35otcr0.RemoteImageDownload.fromJson(data) as T;
    }
    if (t == _i3kglx6m.StoredImage) {
      return _i3kglx6m.StoredImage.fromJson(data) as T;
    }
    if (t == _iz2qjf27.Install) {
      return _iz2qjf27.Install.fromJson(data) as T;
    }
    if (t == _istbflf6.InstallRejectedException) {
      return _istbflf6.InstallRejectedException.fromJson(data) as T;
    }
    if (t == _iln4p86h.RemoteInstallKey) {
      return _iln4p86h.RemoteInstallKey.fromJson(data) as T;
    }
    if (t == _ikiv91es.RemoteReportContext) {
      return _ikiv91es.RemoteReportContext.fromJson(data) as T;
    }
    if (t == _ihpzd5k3.Report) {
      return _ihpzd5k3.Report.fromJson(data) as T;
    }
    if (t == _ipfy84dl.ReportRejectedException) {
      return _ipfy84dl.ReportRejectedException.fromJson(data) as T;
    }
    if (t == _iu27gnfp.QuotaExceededException) {
      return _iu27gnfp.QuotaExceededException.fromJson(data) as T;
    }
    if (t == _i04ejohi.RemoteStockImage) {
      return _i04ejohi.RemoteStockImage.fromJson(data) as T;
    }
    if (t == _ilti7uc9.ServiceUnavailableException) {
      return _ilti7uc9.ServiceUnavailableException.fromJson(data) as T;
    }
    if (t == _ip1otjwk.ServiceUsage) {
      return _ip1otjwk.ServiceUsage.fromJson(data) as T;
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
    if (t == _is.getType<_i9kbx4z0.AccountTier?>()) {
      return (data != null ? _i9kbx4z0.AccountTier.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itqfnsgf.ImageLabelingConfig?>()) {
      return (data != null ? _itqfnsgf.ImageLabelingConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_il54hkej.ImageStorageConfig?>()) {
      return (data != null ? _il54hkej.ImageStorageConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7ei07da.InstallsConfig?>()) {
      return (data != null ? _i7ei07da.InstallsConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia9g9wp9.RemoteAppConfig?>()) {
      return (data != null ? _ia9g9wp9.RemoteAppConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifa12ii1.ReportsConfig?>()) {
      return (data != null ? _ifa12ii1.ReportsConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iadewe5j.RuntimeConfig?>()) {
      return (data != null ? _iadewe5j.RuntimeConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i461qwm6.StockImagesConfig?>()) {
      return (data != null ? _i461qwm6.StockImagesConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4dwxpi4.TierConfig?>()) {
      return (data != null ? _i4dwxpi4.TierConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irne63bc.TiersConfig?>()) {
      return (data != null ? _irne63bc.TiersConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ialc7yx3.TranslationConfig?>()) {
      return (data != null ? _ialc7yx3.TranslationConfig.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i35otcr0.RemoteImageDownload?>()) {
      return (data != null ? _i35otcr0.RemoteImageDownload.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3kglx6m.StoredImage?>()) {
      return (data != null ? _i3kglx6m.StoredImage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iz2qjf27.Install?>()) {
      return (data != null ? _iz2qjf27.Install.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_istbflf6.InstallRejectedException?>()) {
      return (data != null ? _istbflf6.InstallRejectedException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iln4p86h.RemoteInstallKey?>()) {
      return (data != null ? _iln4p86h.RemoteInstallKey.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikiv91es.RemoteReportContext?>()) {
      return (data != null ? _ikiv91es.RemoteReportContext.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihpzd5k3.Report?>()) {
      return (data != null ? _ihpzd5k3.Report.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ipfy84dl.ReportRejectedException?>()) {
      return (data != null ? _ipfy84dl.ReportRejectedException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu27gnfp.QuotaExceededException?>()) {
      return (data != null ? _iu27gnfp.QuotaExceededException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i04ejohi.RemoteStockImage?>()) {
      return (data != null ? _i04ejohi.RemoteStockImage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilti7uc9.ServiceUnavailableException?>()) {
      return (data != null ? _ilti7uc9.ServiceUnavailableException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ip1otjwk.ServiceUsage?>()) {
      return (data != null ? _ip1otjwk.ServiceUsage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilpzzhur.LocalActivity?>()) {
      return (data != null ? _ilpzzhur.LocalActivity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ij5ultnt.LocalSetting?>()) {
      return (data != null ? _ij5ultnt.LocalSetting.fromJson(data) : null) as T;
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
    if (t == List<_i7l2n366.RemoteStockImage>) {
      return (data as List).map((e) => deserialize<_i7l2n366.RemoteStockImage>(e)).toList() as T;
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
      _i9kbx4z0.AccountTier => 'AccountTier',
      _itqfnsgf.ImageLabelingConfig => 'ImageLabelingConfig',
      _il54hkej.ImageStorageConfig => 'ImageStorageConfig',
      _i7ei07da.InstallsConfig => 'InstallsConfig',
      _ia9g9wp9.RemoteAppConfig => 'RemoteAppConfig',
      _ifa12ii1.ReportsConfig => 'ReportsConfig',
      _iadewe5j.RuntimeConfig => 'RuntimeConfig',
      _i461qwm6.StockImagesConfig => 'StockImagesConfig',
      _i4dwxpi4.TierConfig => 'TierConfig',
      _irne63bc.TiersConfig => 'TiersConfig',
      _ialc7yx3.TranslationConfig => 'TranslationConfig',
      _i35otcr0.RemoteImageDownload => 'RemoteImageDownload',
      _i3kglx6m.StoredImage => 'StoredImage',
      _iz2qjf27.Install => 'Install',
      _istbflf6.InstallRejectedException => 'InstallRejectedException',
      _iln4p86h.RemoteInstallKey => 'RemoteInstallKey',
      _ikiv91es.RemoteReportContext => 'RemoteReportContext',
      _ihpzd5k3.Report => 'Report',
      _ipfy84dl.ReportRejectedException => 'ReportRejectedException',
      _iu27gnfp.QuotaExceededException => 'QuotaExceededException',
      _i04ejohi.RemoteStockImage => 'RemoteStockImage',
      _ilti7uc9.ServiceUnavailableException => 'ServiceUnavailableException',
      _ip1otjwk.ServiceUsage => 'ServiceUsage',
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
      case _i9kbx4z0.AccountTier():
        return 'AccountTier';
      case _itqfnsgf.ImageLabelingConfig():
        return 'ImageLabelingConfig';
      case _il54hkej.ImageStorageConfig():
        return 'ImageStorageConfig';
      case _i7ei07da.InstallsConfig():
        return 'InstallsConfig';
      case _ia9g9wp9.RemoteAppConfig():
        return 'RemoteAppConfig';
      case _ifa12ii1.ReportsConfig():
        return 'ReportsConfig';
      case _iadewe5j.RuntimeConfig():
        return 'RuntimeConfig';
      case _i461qwm6.StockImagesConfig():
        return 'StockImagesConfig';
      case _i4dwxpi4.TierConfig():
        return 'TierConfig';
      case _irne63bc.TiersConfig():
        return 'TiersConfig';
      case _ialc7yx3.TranslationConfig():
        return 'TranslationConfig';
      case _i35otcr0.RemoteImageDownload():
        return 'RemoteImageDownload';
      case _i3kglx6m.StoredImage():
        return 'StoredImage';
      case _iz2qjf27.Install():
        return 'Install';
      case _istbflf6.InstallRejectedException():
        return 'InstallRejectedException';
      case _iln4p86h.RemoteInstallKey():
        return 'RemoteInstallKey';
      case _ikiv91es.RemoteReportContext():
        return 'RemoteReportContext';
      case _ihpzd5k3.Report():
        return 'Report';
      case _ipfy84dl.ReportRejectedException():
        return 'ReportRejectedException';
      case _iu27gnfp.QuotaExceededException():
        return 'QuotaExceededException';
      case _i04ejohi.RemoteStockImage():
        return 'RemoteStockImage';
      case _ilti7uc9.ServiceUnavailableException():
        return 'ServiceUnavailableException';
      case _ip1otjwk.ServiceUsage():
        return 'ServiceUsage';
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
    if (dataClassName == 'AccountTier') {
      return deserialize<_i9kbx4z0.AccountTier>(data['data']);
    }
    if (dataClassName == 'ImageLabelingConfig') {
      return deserialize<_itqfnsgf.ImageLabelingConfig>(data['data']);
    }
    if (dataClassName == 'ImageStorageConfig') {
      return deserialize<_il54hkej.ImageStorageConfig>(data['data']);
    }
    if (dataClassName == 'InstallsConfig') {
      return deserialize<_i7ei07da.InstallsConfig>(data['data']);
    }
    if (dataClassName == 'RemoteAppConfig') {
      return deserialize<_ia9g9wp9.RemoteAppConfig>(data['data']);
    }
    if (dataClassName == 'ReportsConfig') {
      return deserialize<_ifa12ii1.ReportsConfig>(data['data']);
    }
    if (dataClassName == 'RuntimeConfig') {
      return deserialize<_iadewe5j.RuntimeConfig>(data['data']);
    }
    if (dataClassName == 'StockImagesConfig') {
      return deserialize<_i461qwm6.StockImagesConfig>(data['data']);
    }
    if (dataClassName == 'TierConfig') {
      return deserialize<_i4dwxpi4.TierConfig>(data['data']);
    }
    if (dataClassName == 'TiersConfig') {
      return deserialize<_irne63bc.TiersConfig>(data['data']);
    }
    if (dataClassName == 'TranslationConfig') {
      return deserialize<_ialc7yx3.TranslationConfig>(data['data']);
    }
    if (dataClassName == 'RemoteImageDownload') {
      return deserialize<_i35otcr0.RemoteImageDownload>(data['data']);
    }
    if (dataClassName == 'StoredImage') {
      return deserialize<_i3kglx6m.StoredImage>(data['data']);
    }
    if (dataClassName == 'Install') {
      return deserialize<_iz2qjf27.Install>(data['data']);
    }
    if (dataClassName == 'InstallRejectedException') {
      return deserialize<_istbflf6.InstallRejectedException>(data['data']);
    }
    if (dataClassName == 'RemoteInstallKey') {
      return deserialize<_iln4p86h.RemoteInstallKey>(data['data']);
    }
    if (dataClassName == 'RemoteReportContext') {
      return deserialize<_ikiv91es.RemoteReportContext>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_ihpzd5k3.Report>(data['data']);
    }
    if (dataClassName == 'ReportRejectedException') {
      return deserialize<_ipfy84dl.ReportRejectedException>(data['data']);
    }
    if (dataClassName == 'QuotaExceededException') {
      return deserialize<_iu27gnfp.QuotaExceededException>(data['data']);
    }
    if (dataClassName == 'RemoteStockImage') {
      return deserialize<_i04ejohi.RemoteStockImage>(data['data']);
    }
    if (dataClassName == 'ServiceUnavailableException') {
      return deserialize<_ilti7uc9.ServiceUnavailableException>(data['data']);
    }
    if (dataClassName == 'ServiceUsage') {
      return deserialize<_ip1otjwk.ServiceUsage>(data['data']);
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
      case _i9kbx4z0.AccountTier:
        return _i9kbx4z0.AccountTier.t;
      case _i3kglx6m.StoredImage:
        return _i3kglx6m.StoredImage.t;
      case _iz2qjf27.Install:
        return _iz2qjf27.Install.t;
      case _ihpzd5k3.Report:
        return _ihpzd5k3.Report.t;
      case _ip1otjwk.ServiceUsage:
        return _ip1otjwk.ServiceUsage.t;
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
