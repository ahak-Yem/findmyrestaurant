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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subText,
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
