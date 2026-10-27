import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/account.dart';

part 'sign_in_result.mapper.dart';

@MappableClass()
sealed class SignInResult with SignInResultMappable {
  const SignInResult();
}

@MappableClass()
class const SignedIn({
  required final Account account,
}) extends SignInResult with SignedInMappable;

@MappableClass()
class const AccountConflict({
  required final GoogleAccount previous,
  required final GoogleAccount next,
}) extends SignInResult with AccountConflictMappable;

@MappableClass()
class const SignInCancelled() extends SignInResult with SignInCancelledMappable;
