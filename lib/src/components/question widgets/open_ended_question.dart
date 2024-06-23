import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class OpenEndedQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final String? answer;

  const OpenEndedQuestion({
    Key? key,
    required this.question,
    this.answer,
  }) : super(key: key);

  @override
  State<OpenEndedQuestion> createState() => _OpenEndedQuestionState();
}

class _OpenEndedQuestionState extends State<OpenEndedQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.answer != null && _controller.text.isEmpty) {
      _controller.text = widget.answer!;
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
            labelText: AppStrings.openEndedQuestionLabelText,
          ),
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
