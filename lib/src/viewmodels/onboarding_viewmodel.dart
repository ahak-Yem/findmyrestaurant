import 'dart:async';
import 'package:findmyrestaurant/src/components/app_toast.dart';
import 'package:findmyrestaurant/src/components/images_container.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/database%20enums/database_models_enum.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/models/email_model.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/complete_onboarding_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/confirm_email_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/signup_page.dart';
import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:findmyrestaurant/src/services/device_info_service.dart';
import 'package:findmyrestaurant/src/services/email_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

class OnboardingViewModel extends ChangeNotifier {
  final List<ImagesContainer> _images = [];
  List<ImagesContainer> get images => _images;
  List<AppCarouselItem> carouselItems = [];
  String? _userID;
  bool isBackToConfirmEmail = false;
  UserModel? _user;
  bool _useSavedUser = false;

  final AppCarouselController appCarouselController = AppCarouselController();

  final DatabaseService _database = DatabaseService.instance;
  final EmailService _emailService = EmailService.instance;
  final AppLaunchService _appLaunchService = AppLaunchService.instance;
  final ConfirmationCodeService _confirmationCodeService = ConfirmationCodeService.instance;

  final StreamController<String> _signupFailureStreamController = StreamController<String>();
  Stream<String> get signupFailureStream => _signupFailureStreamController.stream;

  final StreamController<String> _confirmationCodeStreamController = StreamController<String>();
  Stream<String> get confirmationCodeStreamController => _confirmationCodeStreamController.stream;

  final StreamController<String> _userSavedStreamController = StreamController<String>();
  Stream<String> get userSavedStreamController => _userSavedStreamController.stream;

  final StreamController<bool> _toSurveyBtnStreamController = StreamController<bool>();
  Stream<bool> get toSurveyBtnStreamController => _toSurveyBtnStreamController.stream;

  OnboardingViewModel() {
    _setImages();
    _setAllCarouselItems();
    OnboardingPagesExtension.setAppCarouselController(appCarouselController);
    CompleteOnboardingPage.onSurveyButtonPressedCallback = _notifyToSurveyBtnPressed;
    _checkAndNotifyUserSaved();
    _setUserId();
  }

  Future<bool> onDeviceBackPressed() {
    final currentPage = appCarouselController.currentPageIndex;
    if (currentPage == 0) {
      return Future.value(false);
    }
    appCarouselController.goBack(currentPage: currentPage);
    return Future.value(false);
  }

  set useSavedUser(bool useUser) {
    _useSavedUser = useUser;
  }

  void navigateToSignupWithKnownUser(){
    if(_useSavedUser) {
      UserModel? user = _appLaunchService.user;
      if(user != null) {
        SignupPage.setSavedUser(user);
      }
      appCarouselController.animatedJumpToPage(page: OnboardingPages.signUp.pageIndex);
    }
  }

  Future<void> _setUserId() async{
    _userID = await DeviceInfoService.instance.deviceID;
  }
  
  void _checkAndNotifyUserSaved() {
    if(_appLaunchService.isUserSaved) {
      _notifyUserIsSaved();
    }
  }

  void _setImages() {
    for(var imageName in ImagesNames.values.where((imageName) => imageName.section == ImagesPathsSections.getStarted)) {
      String path = ImagesReaderService.instance.getImagePath(ImagesPathsSections.getStarted, imageName);
      var image = ImagesContainer(imagePath: path, heightPercentage: 45);
      _images.add(image);
    }
  }

  void _setAllCarouselItems(){
    carouselItems.clear();
    for (var page in OnboardingPages.values) {
      carouselItems.add(page.page);
    }
    notifyListeners();
  }

  void onAppCarouselItemChanged(int pageIndex){
    if(OnboardingPages.signUp.pageIndex + 1 == pageIndex){
      onSignupPageChanged(pageIndex);
      return;
    }
    if(OnboardingPages.confirmEmail.pageIndex + 1 == pageIndex){
      onConfirmEmailPageChanged(pageIndex);
      return;
    }
    appCarouselController.setCurrentPageIndex(pageIndex);
    notifyListeners();
  }

  void onSignupPageChanged(int pageIndex) {
    if(isBackToConfirmEmail){
      isBackToConfirmEmail = false;
      return;
    }
    String name = SignupPage.nameController.text;
    String email = SignupPage.emailController.text;
    String password = SignupPage.passwordController.text;
    String confirmPassword = SignupPage.confirmPasswordController.text;

    const String senderEmail = "no-reply@findmyrestaurant.de";
    const String replyToEmail = "contact@findmyrestaurant.de";

    final Map<bool, String> validationResult = _validateSignup(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if(!validationResult.keys.first){
      appCarouselController.goBack(currentPage: pageIndex);
      _notifySignupFailure(validationResult.values.first);
    }
    else{
      if(_userID != null){
        _user = UserModel(_userID!, name: name, email: email, password: password, isEmailConfirmed: false);
        _database.save(DatabaseModelsEnum.user, _userID, _user);
      }
      EmailModel emailModel = EmailModel(
        sender: ContactModel(email: senderEmail, name: AppStrings.appTitle), 
        receivers: [ContactModel(email: email, name: name)], 
        replyTo: ContactModel(email: replyToEmail, name: AppStrings.replyToEmailName),
        emailHtml: "", 
        subject: AppStrings.emailConfirmationSubject,
        previewText: AppStrings.emailConfirmationPreviewText,
        tags: ["Signup Confirmation Email"],
      );
      _emailService.sendEmail(emailModel);
      AppToast.showToast(validationResult.values.first);
      appCarouselController.setCurrentPageIndex(pageIndex);
      notifyListeners();
    }
  }

  Map<bool, String> _validateSignup({
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

  void onConfirmEmailPageChanged(int pageIndex){
    String code = ConfirmEmailPage.confirmationCodeController.text;
    Map<bool, String> validationResult = _validateConfirmationCode(code: code);
    if(!validationResult.keys.first){
      isBackToConfirmEmail = true;
      appCarouselController.goBack(currentPage: pageIndex);
      _notifyConfirmationCodeState(validationResult.values.first);
    }
    else{
      ConfirmEmailPage.emptyConfirmationCodeController();
      _user?.isEmailConfirmed = true;
      _database.save(DatabaseModelsEnum.user, _userID, _user);
      appCarouselController.setCurrentPageIndex(pageIndex);
      AppToast.showToast(validationResult.values.first);
      notifyListeners();
    }
  }

  Map<bool, String> _validateConfirmationCode({required String code}){
    if (code.isEmpty) {
      return {false: AppStrings.emptyCodeErrorText};
    }
    
    if(code.length < 6) {
      return {false: AppStrings.shortCodeErrorText};
    }

    Map<bool, DateTime?> isCodeValid = _confirmationCodeService.verifyCode(code);

    if(isCodeValid.values.first == null){
      return {false: AppStrings.falseCodeErrorText};
    }

    if(DateTime.now().isAfter(isCodeValid.values.first!)){
      return {false: AppStrings.expiredCodeErrorText};
    }

    return {true: AppStrings.codeSuccessfulText};
  }

  void _notifySignupFailure(String errorMessage) {
    _signupFailureStreamController.add(errorMessage);
  }

  void _notifyConfirmationCodeState(String message) {
    _confirmationCodeStreamController.add(message);
  }

  void _notifyUserIsSaved() {
    _userSavedStreamController.add(AppStrings.userSavedText);
  }

  void _notifyToSurveyBtnPressed() {
    _toSurveyBtnStreamController.add(true);
  }

  @override
  void dispose() {
    _signupFailureStreamController.close();
    _confirmationCodeStreamController.close();
    _userSavedStreamController.close();
    _toSurveyBtnStreamController.close();
    _images.clear();
    carouselItems.clear();
    super.dispose();
  }
}
