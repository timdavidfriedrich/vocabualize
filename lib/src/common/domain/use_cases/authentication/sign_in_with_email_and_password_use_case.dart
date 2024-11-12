import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final signInWithEmailAndPasswordUseCaseProvider = AutoDisposeProvider((ref) {
  return SignInWithEmailAndPasswordUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  );
});

class SignInWithEmailAndPasswordUseCase {
  final AuthenticationRepository _authenticationRepository;

  const SignInWithEmailAndPasswordUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<bool> call(String email, String password) {
    return _authenticationRepository.signInWithEmailAndPasswort(email, password);
  }
}
