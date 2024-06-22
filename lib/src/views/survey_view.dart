import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/app_carousel.dart';
import 'package:findmyrestaurant/src/components/carousel_arrows_navbar.dart';
import 'package:findmyrestaurant/src/components/dialogs/muliple_buttons_alert_dialog.dart';
import 'package:findmyrestaurant/src/enums/app_routes_enum.dart';
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
                heightPercentage: 100,
                indicatorPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                onPageChanged: (index) {
                  FocusScope.of(context).unfocus();
                  viewModel.onCarouselItemChanged(index);
                },
                isNotScrollable: true,
                bottomBar: CarouselArrowsNavbar(
                  currentPage: viewModel.appCarouselController.currentPageIndex,
                  pageCount: viewModel.surveyPages.length,
                  iconSize: 30,
                  arrowBtnsColor: AppColors.primaryColor,
                  onBackPressed: viewModel.onBackSurveyQuestion,
                  onNextPressed:() => viewModel.onNextSurveyQuestion(viewModel.surveyQuestions[viewModel.currentQuestionIndex].id),
                ),
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
              AppDynamicButton(
                color: AppColors.primaryColor, 
                textColor: AppColors.appWhite, 
                text: AppStrings.surveyEndedBtn,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, AppRoutes.home.route);
                },
              ),
            ]
          );
        },
      );
    });
  }
}
