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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _viewModel = SurveyViewModel();
    _pageController = _viewModel.appCarouselController;
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
      body: ChangeNotifierProvider(
        create: (context) => _viewModel,
        child: WillPopScope(
          key: widget.key,
          onWillPop: () => _viewModel.onDeviceBackPressed(),
          child: Consumer<SurveyViewModel>(
            builder: (context, viewModel, child) {
              return AppCarousel(
                items: _viewModel.surveyPages,
                pageController: _pageController,
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
