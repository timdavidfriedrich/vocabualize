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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart' as _iais;
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart' as _izehhkf5;

import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/config_endpoint.dart' as _i74a5xur;

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
      'config': _i74a5xur.ConfigEndpoint()
        ..initialize(
          server,
          'config',
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
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).hasAccount(session),
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
    connectors['config'] = _is.EndpointConnector(
      name: 'config',
      endpoint: endpoints['config']!,
      methodConnectors: {
        'fetch': _is.MethodConnector(
          name: 'fetch',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async => (endpoints['config'] as _i74a5xur.ConfigEndpoint).fetch(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()..initializeEndpoints(server);
    modules['serverpod_offline_sync'] = _izehhkf5.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()..initializeEndpoints(server);
  }
}
