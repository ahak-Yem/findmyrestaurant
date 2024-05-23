import 'package:findmyrestaurant/src/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, required this.text, required this.textColor});

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerService>(
      builder: (context, timerService, child) {
        return Text(
          '$text ${timerService.formattedTime}',
          style: TextStyle(fontSize: 16, color: textColor),
        );
      },
    );
  }
}
