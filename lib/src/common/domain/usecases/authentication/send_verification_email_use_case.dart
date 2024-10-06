import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final sendVerificationEmailUseCaseProvider = AutoDisposeProvider((ref) {
  return SendVerificationEmailUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  );
});

class SendVerificationEmailUseCase {
  final AuthenticationRepository _authenticationRepository;

  const SendVerificationEmailUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<void> call() {
    return _authenticationRepository.sendVerificationEmail();
  }
}
