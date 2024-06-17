import 'package:findmyrestaurant/src/pages/survey_question_page.dart';
import 'package:findmyrestaurant/src/viewmodels/survey_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final PageController _pageController = PageController();
  late SurveyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SurveyViewModel();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.surveyQuestions.length,
          itemBuilder: (context, index) {
            final question = viewModel.surveyQuestions[index];
            return SurveyQuestionPage(
              question: question,
              onNext: (response) {
                viewModel.updateUserResponse(question.id, response);
                if (index < viewModel.surveyQuestions.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  viewModel.saveUserPreferences();
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
