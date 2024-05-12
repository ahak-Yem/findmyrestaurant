import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/signup_page.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

class OnboardingViewModel extends ChangeNotifier {
  List<ImagesNames> imageNames = [];
  String designImagePath = '';
  List<AppCarouselItem> carouselItems = [];
  final AppCarouselController appCarouselController = AppCarouselController();

  OnboardingViewModel() {
    _loadImages();
    _setAllCarouselItems();
    OnboardingPagesExtension.setAppCarouselController(appCarouselController);
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

  String _getDesignImagePath(ImagesNames imageName) {
    const ImagesPathsSections imagesSection = ImagesPathsSections.getStarted;
    String path = ImagesReaderService.instance.getImagePath(imagesSection, imageName);
    return path;
  }

  void onAppCarouselItemChanged(int pageIndex){
    //TODO Find a better solution
    if(OnboardingPages.signUp.pageIndex + 1 == pageIndex){
      Map<bool, String> isValid = _validateSignUp();
      if(!isValid.keys.first){
        appCarouselController.goBack(currentPage: pageIndex);
        return;
      }
    }
    int imageIndex = pageIndex % imageNames.length;
    designImagePath = _getDesignImagePath(imageNames[imageIndex]);
    notifyListeners();
  }

  void _setAllCarouselItems(){
    carouselItems.clear();
    for (var page in OnboardingPages.values) {
      carouselItems.add(page.page);
    }
    notifyListeners();
  }

  Map<bool, String> _validateSignUp(){
    String name = SignupPage.nameController.text;
    String email = SignupPage.emailController.text;
    String password = SignupPage.passwordController.text;
    String confirmPassword = SignupPage.confirmPasswordController.text;

    final Map<bool, String> validationResult = appCarouselController.validateSignup(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    return validationResult;
  }
}
