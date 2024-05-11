import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';

class AppCarouselController extends PageController {
  AppCarouselController({
    int initialPage = 0,
    double viewportFraction = 1.0,
    bool keepPage = true,
  }) : super(
          initialPage: initialPage,
          viewportFraction: viewportFraction,
          keepPage: keepPage,
        );

  Future<void> _animateToPage(int page, {Duration duration = const Duration(milliseconds: 300), Curve curve = Curves.ease}) {
    if (hasClients) {
      return super.animateToPage(
        page,
        curve: curve,
        duration: duration,
      );
    }
    return Future(() => null);
  }

  void goNext({required int currentPage}) {
    _animateToPage(currentPage + 1);
  }

  void goBack({required int currentPage}) {
    if (hasClients && page != null) {
      _animateToPage(currentPage - 1);
    }
  }

  Map<bool, String> validateSignup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return {false: AppStrings.emptyFieldsErrorText};
    }

    name = name.trim();
    email = email.trim().toLowerCase();
    password = password.trim();
    confirmPassword = confirmPassword = confirmPassword.trim(); 
    
    //TODO: Try this later:
    // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if (!emailRegExp.hasMatch(email)) {
      return {false: AppStrings.invalidEmailErrorText};
    }

    if (password.length < 8) {
      return {false: AppStrings.passwordLengthErrorText};
    }

    if (password != confirmPassword) {
      return {false: AppStrings.passwordUnmatchErrorText};
    }

    return {true: "Signup successful"};
  }
}
