import 'dart:async';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onTimerComplete;

  const TimerWidget({Key? key, required this.initialSeconds, this.onTimerComplete}) : super(key: key);

  @override
  createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = widget.initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
          if(widget.onTimerComplete != null){
            widget.onTimerComplete;
          }
        }
      });
    });
  }

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.codeExpiresInLabel + _formattedTime,
      style: const TextStyle(fontSize: 16, color: AppColors.red),
    );
  }
}
