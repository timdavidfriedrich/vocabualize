import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/authentication_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/repositories/authentication_repository.dart';

final getCurrentUserUseCaseProvider = AutoDisposeStreamProvider((ref) {
  return GetCurrentUserUseCase(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
  ).call();
});

class GetCurrentUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  const GetCurrentUserUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Stream<AppUser?> call() {
    return _authenticationRepository.getCurrentUser();
  }
}
