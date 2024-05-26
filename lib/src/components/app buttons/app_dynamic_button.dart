import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppDynamicButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final bool? isEnabled;
  final Color disabledTextColor;
  final Color disabledColor;
  final String? disabledText;
  final VoidCallback? onPressed;

  const AppDynamicButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    this.isEnabled = true,
    this.disabledTextColor = AppColors.primaryColor,
    this.disabledColor = AppColors.disabledBtnColor,
    this.disabledText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isEnabled! ? onPressed : null,
      color: isEnabled! ? color : disabledColor,
      textColor: isEnabled! ? textColor : disabledTextColor,
      disabledColor: disabledColor,
      disabledTextColor: disabledTextColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(isEnabled! ? text : (disabledText ?? text)),
    );
  }
}
