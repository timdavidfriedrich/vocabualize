import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final createUserWithEmailAndPasswordUseCaseProvider = AutoDisposeProvider((ref) {
  return CreateUserWithEmailAndPasswordUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  );
});

class CreateUserWithEmailAndPasswordUseCase {
  final AuthenticationRepository _authenticationRepository;

  const CreateUserWithEmailAndPasswordUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<bool> call(String email, String password) {
    return _authenticationRepository.createUserWithEmailAndPassword(email, password);
  }
}
