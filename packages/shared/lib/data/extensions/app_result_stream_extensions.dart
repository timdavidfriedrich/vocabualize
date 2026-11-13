import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:shared/data/extensions/error_extensions.dart';

extension AppResultStreamExtensions<S> on Stream<S> {
  Stream<AppResult<S>> toAppResult() {
    return transform(
      StreamTransformer<S, AppResult<S>>.fromHandlers(
        handleData: (data, sink) => sink.add(Success(data)),
        handleError: (error, stackTrace, sink) => sink.add(Failure(error.toAppError())),
      ),
    );
  }
}
