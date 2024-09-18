import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

class SendPasswordResetEmailUseCase {
  final AuthenticationRepository _authenticationRepository = sl.get<AuthenticationRepository>();

  Future<void> call(String email) {
    return _authenticationRepository.sendPasswordResetEmail(email);
  }
}
