import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final sendPasswordResetEmailUseCaseProvider = AutoDisposeProvider.family((ref, String email) {
  return SendPasswordResetEmailUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  ).call(email);
});

class SendPasswordResetEmailUseCase {
  final AuthenticationRepository _authenticationRepository;

  const SendPasswordResetEmailUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<void> call(String email) {
    return _authenticationRepository.sendPasswordResetEmail(email);
  }
}
