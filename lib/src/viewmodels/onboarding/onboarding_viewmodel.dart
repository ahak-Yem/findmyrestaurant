import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/onboarding_pages_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyrestaurant/src/utility/images_paths_reader.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  String designImagePath = '';
  late List<Widget> carouselItems;

  OnboardingViewModel() {
    _loadImages();
    carouselItems = [];
    _updateCarouselItems(OnboardingPages.intro.pageIndex);
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
    String path = ImagesPathsReader.instance.getImagePath(ImagesPathsSections.getStarted, ImagesNames.muesli.imageName);
    return path;
  }

  void _updateCarouselItems(int pageIndex) {
    carouselItems.clear();

    final page = OnboardingPages.values.firstWhere(
        (page) => page.pageIndex == pageIndex,
        orElse: () => OnboardingPages.intro);
    carouselItems.add(page.page); 

    notifyListeners();
  }
}
