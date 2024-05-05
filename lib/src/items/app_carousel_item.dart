import 'package:flutter/material.dart';

class AppCarouselItem extends StatelessWidget {
  final String headerText;
  final String subText;
  final List<Widget>? buttons;
  final List<Widget>? textFields;

  const AppCarouselItem({
    Key? key,
    required this.headerText,
    required this.subText,
    this.buttons,
    this.textFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              headerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 24),
            child: Text(
              subText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          if (buttons != null) ...buttons!,
          if (textFields != null) ...textFields!,
        ],
      ),
    );
  }
}
