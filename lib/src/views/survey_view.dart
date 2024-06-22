import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/app_carousel.dart';
import 'package:findmyrestaurant/src/components/dialogs/muliple_buttons_alert_dialog.dart';
import 'package:findmyrestaurant/src/viewmodels/survey_viewmodel.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
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
    _setupSurveyEndedListener();
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
          key: widget.key,
          onWillPop: () => _viewModel.onDeviceBackPressed(),
          child: Consumer<SurveyViewModel>(
            builder: (context, viewModel, child) {
              return AppCarousel(
                items: viewModel.surveyPages,
                pageController: viewModel.appCarouselController,
                heightPercentage: 95,
                onPageChanged: (index) {
                  FocusScope.of(context).unfocus();
                  viewModel.onCarouselItemChanged(index);
                },
                isNotScrollable: true,
                showArrows: true,
                onBack: viewModel.onBackSurveyQuestion,
              );
            },
          ),
        ),
      ),
    );
  }

  void _setupSurveyEndedListener() {
    _viewModel.surveyEndedController.listen((bool ended) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MulipleButtonsAlertDialog.buildDialog(
            context, 
            AppStrings.surveyEndedHeader, 
            AppStrings.surveyEndedMessage,
            [
              const AppDynamicButton(
                color: AppColors.primaryColor, 
                textColor: AppColors.appWhite, 
                text: AppStrings.surveyEndedBtn
              ),
            ]
          );
        },
      );
    });
  }
}
