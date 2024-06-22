import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

//TODO:Change the options to picture-options and make the checkbox uses a knife icon
class MultipleChoiceQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final List<String>? savedOptions;

  const MultipleChoiceQuestion({
    super.key,
    required this.question,
    this.savedOptions,
  });

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  late List<String> _selectedOptions;
  

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.savedOptions != null && widget.savedOptions!.isNotEmpty ? List<String>.from(widget.savedOptions!) : [];
    QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.question.options ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
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
                QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOptions);
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
  }
}
