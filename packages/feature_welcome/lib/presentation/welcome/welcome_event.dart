sealed class WelcomeEvent {
  const WelcomeEvent();
}

class const WelcomeLocalUseChosen() extends WelcomeEvent;

class const WelcomeGoogleSignInChosen() extends WelcomeEvent;

class const WelcomeAccountConflictResolved({
  required final bool keepsPreviousAccount,
}) extends WelcomeEvent;
