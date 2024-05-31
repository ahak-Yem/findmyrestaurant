import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/complete_onboarding_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/confirm_email_page.dart';
// import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/extra_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/getstarted_page.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/intro_page.dart';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/items_templates/app_carousel_item.dart';
import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/signup_page.dart';

enum OnboardingPages {
  intro(
    pageIndex: 0
  ),
  getStarted(
    pageIndex: 1
  ),
  signUp(
    pageIndex: 2,
  ),
  confirmEmail(
    pageIndex: 3
  ),
  completeOnboarding(
    pageIndex: 4
  );

  const OnboardingPages({required this.pageIndex});

  final int pageIndex;
}

extension OnboardingPagesExtension on OnboardingPages {  
  static AppCarouselController? _carouselController;
  static AppCarouselController? get  carouselController => _carouselController;

  static void setAppCarouselController(AppCarouselController controller) {
    _carouselController = controller;
  }

  AppCarouselItem get page {
    switch(this) {
      case OnboardingPages.intro: 
        return IntroPage.page;
      case OnboardingPages.getStarted: 
        return GetstartedPage.page;
      case OnboardingPages.signUp:
        return SignupPage.page;
      case OnboardingPages.confirmEmail:
        return ConfirmEmailPage.page;
      case OnboardingPages.completeOnboarding:
        return CompleteOnboardingPage.page;
    }
  }

  static AppCarouselItem getPageByIndex(int index) {
    AppCarouselItem emptyItem = const AppCarouselItem(page: OnboardingPages.intro,);

    if (!OnboardingPages.values.any((page) => page.pageIndex == index)) {
      return emptyItem;
    }
    switch(index) {
      case 0:
        return OnboardingPages.intro.page;
      case 1:
        return OnboardingPages.getStarted.page;
      case 2:
        return OnboardingPages.signUp.page;
      case 3:
        return OnboardingPages.confirmEmail.page;
      case 4:
        return OnboardingPages.completeOnboarding.page;
      default:
        return emptyItem;
    }
  }
}
