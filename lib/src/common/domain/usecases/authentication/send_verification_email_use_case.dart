import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

class SendVerificationEmailUseCase {
  final AuthenticationRepository _authenticationRepository = sl.get<AuthenticationRepository>();

  Future<void> call() {
    return _authenticationRepository.sendVerificationEmail();
  }
}
