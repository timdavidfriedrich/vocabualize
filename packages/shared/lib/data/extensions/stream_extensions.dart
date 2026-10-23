import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';

extension StreamExtensions<S> on Stream<S> {
  Stream<T> switchMap<T>(Stream<T> Function(S value) mapper) {
    StreamSubscription<S>? outerSubscription;
    StreamSubscription<T>? innerSubscription;
    late final StreamController<T> controller;
    controller = StreamController<T>(
      onListen: () {
        outerSubscription = listen(
          (value) {
            final previous = innerSubscription;
            if (previous != null) unawaited(previous.cancel());
            innerSubscription = mapper(value).listen(
              controller.add,
              onError: controller.addError,
            );
          },
          onError: controller.addError,
        );
      },
      onCancel: () async {
        await innerSubscription?.cancel();
        await outerSubscription?.cancel();
      },
    );
    return controller.stream;
  }

  Stream<AppResult<S>> toAppResult() {
    return transform(
      StreamTransformer<S, AppResult<S>>.fromHandlers(
        handleData: (data, sink) => sink.add(Success(data)),
        handleError: (error, stackTrace, sink) =>
            sink.add(Failure(UnexpectedError(error.toString()))),
      ),
    );
  }
}
