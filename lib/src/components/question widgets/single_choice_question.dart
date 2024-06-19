import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class SingleChoiceQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final Function(String) onNext;

  const SingleChoiceQuestion({
    super.key,
    required this.question,
    required this.onNext,
  });

  @override
  State<SingleChoiceQuestion> createState() => _SingleChoiceQuestionState();
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final options = widget.question.options ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return index < options.length - 1 ? RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (String? value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ) :
          Column(
            children: [
              RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              AppDynamicButton(
                color: AppColors.primaryColor,
                textColor: AppColors.appWhite,
                text: AppStrings.goNextBtn,
                onPressed: () {
                  widget.onNext(_selectedOption ?? "");
                },
              ),
            ]
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_selectedOption != null) {
      widget.onNext(_selectedOption!);
    }
  }
}
