import 'package:flutter/material.dart';

enum AppState { idle, loading, error }

class BaseChangeNotifier extends ChangeNotifier {
  AppState _state = AppState.idle;

  AppState get state => _state;

  void setState({AppState? state}) {
    if (state == null) {
      notifyListeners();
      return;
    } else {
      _state = state;
      notifyListeners();
    }
  }
}
