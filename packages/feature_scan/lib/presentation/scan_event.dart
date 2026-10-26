sealed class ScanEvent {
  const ScanEvent();
}

class const ScanStarted() extends ScanEvent;

class const ScanConnectionRestored() extends ScanEvent;

class const ScanPhotoTaken({
  required final String path,
}) extends ScanEvent;

class const ScanRetakeRequested() extends ScanEvent;

class const ScanSettingsOpened() extends ScanEvent;
