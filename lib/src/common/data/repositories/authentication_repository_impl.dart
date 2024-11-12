import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/data_sources/authentication_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_connection_client.dart';
import 'package:vocabualize/src/common/data/mappers/auth_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final authenticationRepositoryProvider = Provider((ref) {
  return AuthenticationRepositoryImpl(
    connectionClient: ref.watch(remoteConnectionClientProvider),
    authenticationDataSource: ref.watch(authenticationDataSourceProvider),
  );
});

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteConnectionClient _connectionClient;
  final AuthenticationDataSource _authenticationDataSource;

  final StreamController<AppUser?> _userStreamController = StreamController<AppUser?>.broadcast();
  Stream<AppUser?> get stream => _userStreamController.stream.asBroadcastStream();

  AuthenticationRepositoryImpl({
    required RemoteConnectionClient connectionClient,
    required AuthenticationDataSource authenticationDataSource,
  })  : _connectionClient = connectionClient,
        _authenticationDataSource = authenticationDataSource {
    _initUserStream();
  }

  Future<void> _initUserStream() async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    _userStreamController.sink.add(pocketbase.authStore.toAppUser());
    _listenToUserChanges();
    Log.hint("User stream initialized");
  }

  void _listenToUserChanges() async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    pocketbase.authStore.onChange.map((event) {
      if (event.model == null) {
        return null;
      }
      return event.toAppUser();
    }).forEach((AppUser? user) async {
      _userStreamController.sink.add(user);
      Log.hint("User stream: Cloud user changed to $user");
    });
  }

  @override
  Stream<AppUser?> getCurrentUser() {
    return _userStreamController.stream;
  }

  @override
  Future<bool> createUserWithEmailAndPassword(String email, String password) {
    return _authenticationDataSource.createUserWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> signInWithEmailAndPasswort(String email, String password) {
    return _authenticationDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> signOut() {
    return _authenticationDataSource.signOut();
  }

  @override
  Future<void> sendVerificationEmail() {
    return _authenticationDataSource.sendVerificationEmail();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _authenticationDataSource.sendPasswordResetEmail(email);
  }
}
