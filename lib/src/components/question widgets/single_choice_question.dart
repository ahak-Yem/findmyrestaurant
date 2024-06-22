import 'package:findmyrestaurant/src/utility/survey_response_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

//TODO:Change the options to picture-options and make the radio cicles uses an egg icon
class SingleChoiceQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final String? savedOption;

  const SingleChoiceQuestion({
    super.key,
    required this.question,
    this.savedOption,
  });

  @override
  State<SingleChoiceQuestion> createState() => _SingleChoiceQuestionState();
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    if (widget.savedOption != null){
      _selectedOption = widget.savedOption!.isNotEmpty ?  widget.savedOption : null;
      SurveyResponseUtil.setResponse(widget.question.id, _selectedOption);
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.question.options ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (String? value) {
              setState(() {
                _selectedOption = value;
                SurveyResponseUtil.setResponse(widget.question.id, _selectedOption);
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
