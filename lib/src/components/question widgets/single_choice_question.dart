import 'package:findmyrestaurant/src/components/cards/image_radiobutton_card.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/utility/question_widgets_answers_util.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class SingleChoiceQuestion extends StatefulWidget {
  final DietarySurveyQuestionsModel question;
  final String? savedOption;

  const SingleChoiceQuestion({
    Key? key,
    required this.question,
    this.savedOption,
  }) : super(key: key);

  @override
  State<SingleChoiceQuestion> createState() => _SingleChoiceQuestionState();
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    if (widget.savedOption != null && _selectedOption.isEmpty) {
      _selectedOption = widget.savedOption!.isNotEmpty ? widget.savedOption! : "";
      QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOption);
      QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(widget.question.id, _selectedOption.isNotEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.question.options ?? [];
    final images =  widget.question.images ?? {};

    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return ImageRadioButtonCard(
            label: option,
            imagePath: images[option] ?? ImagesReaderService.instance.getImagePath(ImagesPathsSections.extra, ImagesNames.noImagePlaceholder),
            isSelected: _selectedOption == option,
            onSelected: (isSelected) {
              setState(() {
                _selectedOption = isSelected ? option : "";
                QuestionWidgetsAnswersUtil.setResponse(widget.question.id, _selectedOption);
                QuestionWidgetsAnswersUtil.notifyIsQuestionAnswered(widget.question.id, _selectedOption.isNotEmpty);
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
