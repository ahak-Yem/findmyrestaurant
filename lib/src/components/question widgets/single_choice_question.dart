import 'package:findmyrestaurant/src/components/cards/image_radiobutton_card.dart';
import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

//TODO:Make the radio cicles uses an egg icon
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
      QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOption);
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
          return widget.question.options?.length == widget.question.images?.length ? 
          ImageRadioButtonCard(
            label: option,
            imagePath: widget.question.images![option]!,
            isSelected: _selectedOption == option,
            onSelected: (isSelected) {
              setState(() {
                _selectedOption = isSelected ? option : null;
                QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOption);
              });
            },
          ) : 
          RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (String? value) {
              setState(() {
                _selectedOption = value;
                QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOption);
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
