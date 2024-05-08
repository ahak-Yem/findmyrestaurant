import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:flutter/material.dart';

class AppCarouselItem extends StatelessWidget {
  final OnboardingPages page;
  final String? headerText;
  final String? subText;
  final List<Widget>? buttons;
  final List<Widget>? textFields;

  const AppCarouselItem({
    Key? key,
    required this.page,
    this.headerText,
    this.subText,
    this.buttons,
    this.textFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(page != OnboardingPages.signUp)...
              [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
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
              if (textFields != null)...textFields!.map((textField) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: textField,
              )),
              const SizedBox(height: 36),
              if (buttons != null) ...buttons!,
            ],
          ),
        ),
        if(page == OnboardingPages.signUp)...
        [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
        ]
      ],
    );
  }
}
