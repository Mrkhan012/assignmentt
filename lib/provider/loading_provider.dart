
import 'dart:async';

import 'package:flutter/material.dart';

/// ------------------- PROVIDER MODELS -------------------

class LoadingProvider extends ChangeNotifier {
  double progress = 0.0;
  Timer? _timer;

  void startLoading(VoidCallback onComplete) {
    const duration = Duration(milliseconds: 40);
    _timer = Timer.periodic(duration, (t) {
      progress += 0.01;
      if (progress >= 1.0) {
        progress = 1.0;
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
