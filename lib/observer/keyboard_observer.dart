import 'package:flutter/material.dart';

class KeyboardObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _closeKeyboard();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _closeKeyboard();
  }

  void _closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}