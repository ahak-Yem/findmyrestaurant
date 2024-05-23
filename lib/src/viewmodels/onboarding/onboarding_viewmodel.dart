import 'dart:async';
import 'package:findmyrestaurant/src/components/app_toast.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/database%20enums/database_models_enum.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/models/email_model.dart';
import 'package:findmyrestaurant/src/models/user_model.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/confirm_email_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/signup_page.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:findmyrestaurant/src/services/device_info_service.dart';
import 'package:findmyrestaurant/src/services/email_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

class OnboardingViewModel extends ChangeNotifier {
  List<ImagesNames> imageNames = [];
  String designImagePath = '';
  List<AppCarouselItem> carouselItems = [];
  String? _userID;
  bool isBackToConfirmEmail = false;

  final AppCarouselController appCarouselController = AppCarouselController();

  final DatabaseService _database = DatabaseService.instance;
  final EmailService _emailService = EmailService.instance;

  final StreamController<String> _signupFailureStreamController = StreamController<String>();
  Stream<String> get signupFailureStream => _signupFailureStreamController.stream;

  final StreamController<String> _confirmationCodeStreamController = StreamController<String>();
  Stream<String> get confirmationCodeStreamController => _confirmationCodeStreamController.stream;

  OnboardingViewModel() {
    _loadImages();
    _setAllCarouselItems();
    OnboardingPagesExtension.setAppCarouselController(appCarouselController);
    _setUserId();
  }

  Future<void> _setUserId() async{
    _userID = await DeviceInfoService.instance.deviceID;
  }

  void _loadImages() {
    try {
      imageNames = ImagesNames.values;
      designImagePath = _getDesignImagePath(imageNames[0]);

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading images: $e');
      }
    }
  }

  void _setAllCarouselItems(){
    carouselItems.clear();
    for (var page in OnboardingPages.values) {
      carouselItems.add(page.page);
    }
    notifyListeners();
  }

  String _getDesignImagePath(ImagesNames imageName) {
    const ImagesPathsSections imagesSection = ImagesPathsSections.getStarted;
    String path = ImagesReaderService.instance.getImagePath(imagesSection, imageName);
    return path;
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
    int imageIndex = pageIndex % imageNames.length;
    designImagePath = _getDesignImagePath(imageNames[imageIndex]);
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

    final Map<bool, String> validationResult = appCarouselController.validateSignup(
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
        UserModel user = UserModel(_userID!, name: name, email: email, password: password);
        _database.save(DatabaseModelsEnum.user, _userID, user);
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
      int imageIndex = pageIndex % imageNames.length;
      designImagePath = _getDesignImagePath(imageNames[imageIndex]);
      notifyListeners();
    }
  }

  void onConfirmEmailPageChanged(int pageIndex){
    String code = ConfirmEmailPage.confirmationCodeController.text;
    Map<bool, String> validationResult = appCarouselController.validateConfirmationCode(code: code);
    if(!validationResult.keys.first){
      isBackToConfirmEmail = true;
      appCarouselController.goBack(currentPage: pageIndex);
    }
    else{
      int imageIndex = pageIndex % imageNames.length;
      designImagePath = _getDesignImagePath(imageNames[imageIndex]);
      notifyListeners();
    }
    _notifyConfirmationCode(validationResult.values.first);
  }

  void _notifySignupFailure(String errorMessage) {
    _signupFailureStreamController.add(errorMessage);
  }

  void _notifyConfirmationCode(String message) {
    _confirmationCodeStreamController.add(message);
  }
}
