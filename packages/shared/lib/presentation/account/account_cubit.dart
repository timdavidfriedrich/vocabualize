import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@injectable
class AccountCubit extends Cubit<Account?> {
  AccountCubit(this._accountRepository) : super(null);

  final AccountRepository _accountRepository;
  StreamSubscription<AppResult<AuthStatus>>? _subscription;

  void start() {
    _subscription ??= _accountRepository.watchAuthStatus().listen((result) {
      if (result case Success(:final data)) {
        emit(switch (data) {
          AuthAuthenticated(:final account) => account,
          AuthUnknown() || AuthUnauthenticated() => null,
        });
      }
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
