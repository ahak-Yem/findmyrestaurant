import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class OpenEndedQuestion extends StatelessWidget {
  final DietarySurveyQuestionsModel question;
  final String? answer;

  const OpenEndedQuestion({
    Key? key,
    required this.question,
    this.answer,
  }) : super(key: key);

  TextEditingController init() {
    TextEditingController controller = TextEditingController();
    if (answer != null) {
      controller.text = answer.toString();
      QuestionWidgetsAnswersUtil.setResponse(question.id, controller.text);
      QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(question.id, controller.text.isNotEmpty);
    }
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = init();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: AppStrings.openEndedQuestionLabelText,
          ),
          onSubmitted: (value) {
            QuestionWidgetsAnswersUtil.setResponse(question.id, value);
            QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(question.id, controller.text.isNotEmpty);
          },
        ),
      ],
    );
  }
}
