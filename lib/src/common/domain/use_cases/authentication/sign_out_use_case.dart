import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final signOutUseCaseProvider = AutoDisposeProvider((ref) {
  return SignOutUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  );
});

class SignOutUseCase {
  final AuthenticationRepository _authenticationRepository;

  const SignOutUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<bool> call() {
    return _authenticationRepository.signOut();
  }
}
