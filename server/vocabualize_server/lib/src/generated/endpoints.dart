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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart' as _iais;
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart' as _izehhkf5;
import 'package:vocabualize_server/src/generated/reports/remote_report_context.dart' as _ivmefvxj;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/account_endpoint.dart' as _iaho7ul5;
import '../endpoints/ai_endpoint.dart' as _igsjf4zh;
import '../endpoints/config_endpoint.dart' as _i74a5xur;
import '../endpoints/image_endpoint.dart' as _iu0td00j;
import '../endpoints/report_endpoint.dart' as _i90z2r7i;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'googleIdp': _i71axiz0.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'account': _iaho7ul5.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'ai': _igsjf4zh.AiEndpoint()
        ..initialize(
          server,
          'ai',
          null,
        ),
      'config': _i74a5xur.ConfigEndpoint()
        ..initialize(
          server,
          'config',
          null,
        ),
      'image': _iu0td00j.ImageEndpoint()
        ..initialize(
          server,
          'image',
          null,
        ),
      'report': _i90z2r7i.ReportEndpoint()
        ..initialize(
          server,
          'report',
          null,
        ),
    };
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).login(
                session,
                idToken: params['idToken'],
                accessToken: params['accessToken'],
              ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).loginWithCode(
                session,
                code: params['code'],
                codeVerifier: params['codeVerifier'],
                redirectUri: params['redirectUri'],
              ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint).refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['account'] = _is.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['account'] as _iaho7ul5.AccountEndpoint).delete(session),
        ),
      },
    );
    connectors['ai'] = _is.EndpointConnector(
      name: 'ai',
      endpoint: endpoints['ai']!,
      methodConnectors: {
        'translate': _is.MethodConnector(
          name: 'translate',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sourceLanguage': _is.ParameterDescription(
              name: 'sourceLanguage',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetLanguage': _is.ParameterDescription(
              name: 'targetLanguage',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _igsjf4zh.AiEndpoint).translate(
                session,
                params['text'],
                params['sourceLanguage'],
                params['targetLanguage'],
              ),
        ),
        'searchStockImages': _is.MethodConnector(
          name: 'searchStockImages',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'language': _is.ParameterDescription(
              name: 'language',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _igsjf4zh.AiEndpoint).searchStockImages(
                session,
                params['query'],
                params['language'],
              ),
        ),
        'labelImage': _is.MethodConnector(
          name: 'labelImage',
          params: {
            'image': _is.ParameterDescription(
              name: 'image',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
            'language': _is.ParameterDescription(
              name: 'language',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _igsjf4zh.AiEndpoint).labelImage(
                session,
                params['image'],
                params['language'],
              ),
        ),
      },
    );
    connectors['config'] = _is.EndpointConnector(
      name: 'config',
      endpoint: endpoints['config']!,
      methodConnectors: {
        'fetch': _is.MethodConnector(
          name: 'fetch',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['config'] as _i74a5xur.ConfigEndpoint).fetch(session),
        ),
        'serverTime': _is.MethodConnector(
          name: 'serverTime',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['config'] as _i74a5xur.ConfigEndpoint).serverTime(session),
        ),
      },
    );
    connectors['image'] = _is.EndpointConnector(
      name: 'image',
      endpoint: endpoints['image']!,
      methodConnectors: {
        'createUpload': _is.MethodConnector(
          name: 'createUpload',
          params: {
            'imageId': _is.ParameterDescription(
              name: 'imageId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'variant': _is.ParameterDescription(
              name: 'variant',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'byteSize': _is.ParameterDescription(
              name: 'byteSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint).createUpload(
                session,
                params['imageId'],
                params['variant'],
                params['byteSize'],
              ),
        ),
        'verifyUpload': _is.MethodConnector(
          name: 'verifyUpload',
          params: {
            'imageId': _is.ParameterDescription(
              name: 'imageId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'variant': _is.ParameterDescription(
              name: 'variant',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint).verifyUpload(
                session,
                params['imageId'],
                params['variant'],
              ),
        ),
        'findMissing': _is.MethodConnector(
          name: 'findMissing',
          params: {
            'imageIds': _is.ParameterDescription(
              name: 'imageIds',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'variant': _is.ParameterDescription(
              name: 'variant',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint).findMissing(
                session,
                params['imageIds'],
                params['variant'],
              ),
        ),
        'createDownloads': _is.MethodConnector(
          name: 'createDownloads',
          params: {
            'imageIds': _is.ParameterDescription(
              name: 'imageIds',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'variant': _is.ParameterDescription(
              name: 'variant',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint).createDownloads(
                session,
                params['imageIds'],
                params['variant'],
              ),
        ),
      },
    );
    connectors['report'] = _is.EndpointConnector(
      name: 'report',
      endpoint: endpoints['report']!,
      methodConnectors: {
        'sendFeedback': _is.MethodConnector(
          name: 'sendFeedback',
          params: {
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<_ivmefvxj.RemoteReportContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i90z2r7i.ReportEndpoint).sendFeedback(
                session,
                params['message'],
                params['context'],
              ),
        ),
        'sendTranslationReport': _is.MethodConnector(
          name: 'sendTranslationReport',
          params: {
            'source': _is.ParameterDescription(
              name: 'source',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'target': _is.ParameterDescription(
              name: 'target',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sourceLanguage': _is.ParameterDescription(
              name: 'sourceLanguage',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetLanguage': _is.ParameterDescription(
              name: 'targetLanguage',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<_ivmefvxj.RemoteReportContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i90z2r7i.ReportEndpoint).sendTranslationReport(
                session,
                params['source'],
                params['target'],
                params['sourceLanguage'],
                params['targetLanguage'],
                params['note'],
                params['context'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()..initializeEndpoints(server);
    modules['serverpod_offline_sync'] = _izehhkf5.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()..initializeEndpoints(server);
  }
}
