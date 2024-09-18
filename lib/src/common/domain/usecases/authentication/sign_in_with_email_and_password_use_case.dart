import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthenticationRepository _authenticationRepository = sl.get<AuthenticationRepository>();

  Future<bool> call(String email, String password) {
    return _authenticationRepository.signInWithEmailAndPasswort(email, password);
  }
}
