import 'package:flutter/material.dart';

class AppCarouselItem extends StatelessWidget {
  final String? headerText;
  final String? subText;
  final List<Widget>? buttons;
  final List<Widget>? textFields;

  const AppCarouselItem({
    Key? key,
    this.headerText,
    this.subText,
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
          if (headerText != null && headerText!.isNotEmpty) ...[  
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
              child: Text(
                headerText!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          if (subText != null && subText!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 24),
              child: Text(
                subText!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
          if (textFields != null) ...textFields!,
          const SizedBox(height: 16),
          if (buttons != null) ...buttons!,
        ],
      ),
    );
  }
}
