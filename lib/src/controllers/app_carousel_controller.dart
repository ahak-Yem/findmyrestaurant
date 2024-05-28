import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';

class AppCarouselController extends PageController {
  AppCarouselController({
    int initialPage = 0,
    double viewportFraction = 1.0,
    bool keepPage = true,
  }) : super( initialPage: initialPage, viewportFraction: viewportFraction, keepPage: keepPage, );

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  
  void setCurrentPageIndex(int pageIndex) {
    _currentPageIndex = pageIndex;
  }

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

  Map<bool, String> validateConfirmationCode({required String code}){
    final ConfirmationCodeService confirmationCodeService = ConfirmationCodeService.instance;
    if (code.isEmpty) {
      return {false: AppStrings.emptyCodeErrorText};
    }
    
    if(code.length < 6) {
      return {false: AppStrings.shortCodeErrorText};
    }

    Map<bool, DateTime?> isCodeValid = confirmationCodeService.verifyCode(code);

    if(isCodeValid.values.first == null){
      return {false: AppStrings.falseCodeErrorText};
    }

    if(DateTime.now().isAfter(isCodeValid.values.first!)){
      return {false: AppStrings.expiredCodeErrorText};
    }

    return {true: AppStrings.codeSuccessfulText};
  }
}
