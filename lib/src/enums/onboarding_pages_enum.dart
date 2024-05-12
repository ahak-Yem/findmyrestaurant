import 'package:findmyrestaurant/src/pages/onboarding_carousel_pages/extra_page.dart';
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
  extra(
    pageIndex: 3,
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
      case OnboardingPages.extra:
        return ExtraPage.page;
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
      // Add case for the new page
      case 3:
        return OnboardingPages.extra.page;
      default:
        return emptyItem;
    }
  }
}
