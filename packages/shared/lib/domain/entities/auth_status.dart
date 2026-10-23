import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/account.dart';

part 'auth_status.mapper.dart';

@MappableClass()
sealed class AuthStatus with AuthStatusMappable {
  const AuthStatus();
}

@MappableClass()
class const AuthUnknown() extends AuthStatus with AuthUnknownMappable;

@MappableClass()
class const AuthUnauthenticated() extends AuthStatus with AuthUnauthenticatedMappable;

@MappableClass()
class const AuthAuthenticated({
  required final Account account,
}) extends AuthStatus with AuthAuthenticatedMappable;
