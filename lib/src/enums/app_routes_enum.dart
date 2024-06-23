import 'package:findmyrestaurant/src/views/home_view.dart';
import 'package:findmyrestaurant/src/views/onboarding_view.dart';
import 'package:findmyrestaurant/src/views/survey_view.dart';
import 'package:flutter/material.dart';

enum AppRoutes {
  onboarding,
  survey,
  home,
}

extension AppRoutesExtension on AppRoutes {
  String get route {
    switch(this) {
      case AppRoutes.onboarding:
        return '/';
      case AppRoutes.survey:
        return '/survey';
      case AppRoutes.home:
        return '/home';
    }
  }

  Widget get view {
    switch(this) {
      case AppRoutes.onboarding:
        return const OnboardingView();
      case AppRoutes.survey:
        return const SurveyView();
        case AppRoutes.home:
          return const HomeView();
    }
  }
}
