import 'package:flutter/material.dart';

class AppDynamicButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback? onPressed;

  const AppDynamicButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      textColor: textColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text),
    );
  }
}
