import 'dart:async';
import 'package:flutter/material.dart';

class TimerService with ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds = 0;
  int _initialSeconds = 0;
  int get remainingSeconds => _remainingSeconds;

  bool _isActive = false;
  bool get isActive => _isActive;

  String get formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer({required int seconds}) {
    _initialSeconds = seconds;
    _remainingSeconds = seconds;
    _timer?.cancel();
    _isActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _isActive = false;
        notifyListeners();
        timer.cancel();
      }
    });
  }

  void resetTimer({int? resetSeconds}) {
    startTimer(seconds: resetSeconds ?? _initialSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
