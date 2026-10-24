sealed class WelcomeEvent {
  const WelcomeEvent();
}

class const WelcomeLocalUseChosen() extends WelcomeEvent;

class const WelcomeGoogleSignInChosen() extends WelcomeEvent;
