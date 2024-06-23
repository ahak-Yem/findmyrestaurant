import 'package:findmyrestaurant/src/components/app%20buttons/app_dynamic_button.dart';
import 'package:findmyrestaurant/src/components/dialogs/app_alert_dialog.dart';
import 'package:findmyrestaurant/src/components/dialogs/muliple_buttons_alert_dialog.dart';
import 'package:findmyrestaurant/src/components/dot_page_indicator.dart';
import 'package:findmyrestaurant/src/enums/app_routes_enum.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findmyrestaurant/src/viewmodels/onboarding_viewmodel.dart';
import 'package:findmyrestaurant/src/components/app_carousel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OnboardingViewModel();
    _setupSignupFailureListener();
    _setupCodeConfirmationListener();
    _setupSavedUserListener();
    _setupOnToSurveyBtnPressedListener();
  }
  
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: WillPopScope(
        key: widget.key,
        onWillPop: () => viewModel.onDeviceBackPressed(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDesignImage(),
              _buildCarousel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesignImage() {
    return Consumer<OnboardingViewModel>(
      builder: (context, viewModel, _) {
        if(viewModel.images.isNotEmpty){
          return viewModel.images[viewModel.appCarouselController.currentPageIndex];
        }
        return const SizedBox(height: 0, width: 0,);
      },
    );
  }

  Widget _buildCarousel() {
    return Consumer<OnboardingViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.carouselItems.isNotEmpty && viewModel.carouselItems != []) {
          return AppCarousel(
            items: viewModel.carouselItems,
            pageController: viewModel.appCarouselController,
            heightPercentage: 55,
            indicatorPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            isNotScrollable: false,
            onPageChanged: (index) {
              FocusScope.of(context).unfocus();
              viewModel.onAppCarouselItemChanged(index);
            },
            bottomBar: PageIndicator (
              currentPage: viewModel.appCarouselController.currentPageIndex,
              pageCount: viewModel.carouselItems.length,
            ),
          );
        } else {
          return const SizedBox(height: 0, width: 0);
        }
      },
    );
  }
  
  void _setupSignupFailureListener() {
    viewModel.signupFailureStream.listen((String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppAlertDialog.buildDialog(context, AppStrings.signupFailedHeader, errorMessage);
        },
      );
    });
  }

  void _setupCodeConfirmationListener() {
    viewModel.confirmationCodeStreamController.listen((String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppAlertDialog.buildDialog(context, AppStrings.confirmationEmailHeader, message);
        },
      );
    });
  }

  void _setupOnToSurveyBtnPressedListener() {
    viewModel.toSurveyBtnStreamController.listen((event) {
      if (event) {
        Navigator.pushReplacementNamed(context, AppRoutes.survey.route);
      }
    });
  }

  void _setupSavedUserListener() {
    viewModel.userSavedStreamController.listen((String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MulipleButtonsAlertDialog.buildDialog(
            context,
            AppStrings.userSavedHeader, 
            message,
            [
              AppDynamicButton(
                text: AppStrings.useSavedUserBtn,
                color: AppColors.primaryColor,
                textColor: AppColors.appWhite,
                onPressed: () {
                  viewModel.useSavedUser = true;
                  viewModel.navigateToSignupWithKnownUser();
                  Navigator.of(context).pop();
                },
              ),
              AppDynamicButton(
                text: AppStrings.dismissString,
                color: AppColors.appWhite,
                textColor: AppColors.primaryColor,
                onPressed: () {
                  viewModel.useSavedUser = false;
                  Navigator.of(context).pop();
                },
              ),
            ]
          );
        },
      );
    });
  }
}
