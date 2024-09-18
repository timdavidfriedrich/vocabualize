import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

class SignOutUseCase {
  final AuthenticationRepository _authenticationRepository = sl.get<AuthenticationRepository>();

  Future<bool> call() {
    return _authenticationRepository.signOut();
  }
}
