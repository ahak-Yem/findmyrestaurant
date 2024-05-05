import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:findmyrestaurant/src/items/app_carousel_item.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

class OnboardingViewModel extends ChangeNotifier {
  String designImagePath = '';
  List<AppCarouselItem> carouselItems = [];

  OnboardingViewModel() {
    _loadImages();
    _setAllCarouselItems();
  }

  void _loadImages() {
    try {
      designImagePath = _getDesignImagePath();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading images: $e');
      }
    }
  }

  String _getDesignImagePath() {
    String path = ImagesReaderService.instance.getImagePath(ImagesPathsSections.getStarted, ImagesNames.muesli.imageName);
    return path;
  }

  void onAppCarouselItemChanged(int pageIndex){
    _updateCarouselItems(pageIndex);
  }

  void _updateCarouselItems(int pageIndex) {
    carouselItems.clear();

    final page = OnboardingPagesExtension.getPageByIndex(pageIndex);
    carouselItems.add(page); 

    notifyListeners();
  }

  void _setAllCarouselItems(){
    carouselItems.clear();
    for (var page in OnboardingPages.values) {
      carouselItems.add(page.page);
    }
    notifyListeners();
  }
}
