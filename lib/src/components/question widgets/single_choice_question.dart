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
    return Column(
      children: widget.question.options!.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value;
            });
          },
        );
      }).toList(),
    );
  }
}
