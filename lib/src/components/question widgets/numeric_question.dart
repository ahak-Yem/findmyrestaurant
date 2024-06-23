import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class NumericQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final int? answer;

  const NumericQuestion({
    Key? key,
    required this.question,
    this.answer,
  }) : super(key: key);

  @override
  State<NumericQuestion> createState() => _NumericQuestionState();
}

class _NumericQuestionState extends State<NumericQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState(); 
    if (widget.answer != null && _controller.text.isEmpty) {
      _controller.text = widget.answer.toString();
      QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _controller.text);
      QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(widget.question.id, _controller.text.isNotEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: AppStrings.numericQuestionLabelText,
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            QuestionWidgetsAnswersUtil.setResponse(widget.question.id, value);
            QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(widget.question.id, value.isNotEmpty);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
