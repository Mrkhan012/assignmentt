

import 'dart:async';

import 'package:flutter/material.dart';


class MatchProvider extends ChangeNotifier {
  int remaining = 20;
  Timer? _timer;

  void startCountdown(VoidCallback onComplete) {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining > 0) remaining--;
      else {
        _timer?.cancel();
        onComplete();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}