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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              headerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
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
                fontSize: 14,
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
