import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final Function(List<String>) onNext;

  const MultipleChoiceQuestion({
    super.key,
    required this.question,
    required this.onNext,
  });

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  final List<String> _selectedOptions = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.question.options!.length,
        itemBuilder: (context, index) {
          final option = widget.question.options![index];
          return CheckboxListTile(
            title: Text(option),
            value: _selectedOptions.contains(option),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _selectedOptions.add(option);
                } else {
                  _selectedOptions.remove(option);
                }
              });
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.onNext(_selectedOptions);
  }
}
