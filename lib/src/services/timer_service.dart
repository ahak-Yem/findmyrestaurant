import 'dart:async';
import 'package:flutter/material.dart';

class TimerService with ChangeNotifier {
  // static final TimerService _instance = TimerService._internal();
  // static TimerService get instance => _instance;
  // factory TimerService() => _instance;
  // TimerService._internal();

  Timer? _timer;
  late int _remainingSeconds;
  int _initialSeconds = 0;

  int get remainingSeconds => _remainingSeconds;

  String get formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer({required int seconds}) {
    _initialSeconds = seconds;
    _remainingSeconds = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    startTimer(seconds: _initialSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
