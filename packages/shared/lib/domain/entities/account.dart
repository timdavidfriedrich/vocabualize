import 'package:dart_mappable/dart_mappable.dart';

part 'account.mapper.dart';

@MappableClass()
sealed class Account with AccountMappable {
  const Account();
}

@MappableClass()
class const LocalAccount() extends Account with LocalAccountMappable;

@MappableClass()
class const GoogleAccount({
  required final String id,
  required final String? name,
  required final String? email,
  required final String? picturePath,
}) extends Account with GoogleAccountMappable;
