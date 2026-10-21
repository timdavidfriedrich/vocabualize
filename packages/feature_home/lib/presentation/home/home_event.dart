sealed class HomeEvent {
  const HomeEvent();
}

class const HomeStarted() extends HomeEvent;

class const HomeRefreshed() extends HomeEvent;
