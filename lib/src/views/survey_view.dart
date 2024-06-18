import 'package:findmyrestaurant/src/components/app_carousel.dart';
import 'package:findmyrestaurant/src/viewmodels/survey_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  late SurveyViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SurveyViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider<SurveyViewModel>.value(
        value: _viewModel,
        child: WillPopScope(
          onWillPop: () => _viewModel.onDeviceBackPressed(),
          child: Consumer<SurveyViewModel>(
            builder: (context, viewModel, child) {
              return AppCarousel(
                items: viewModel.surveyPages,
                pageController: viewModel.appCarouselController,
                heightPercentage: 95,
                onPageChanged: (index) {
                  viewModel.currentQuestionIndex = index;
                },
                isNotScrollable: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
