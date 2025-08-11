import 'dart:async';

extension SafeCompleter<T> on Completer<T> {
  void safeCompleter([FutureOr<T>? value]) {
    if (!isCompleted) {
      complete(value);
    }
  }
}
