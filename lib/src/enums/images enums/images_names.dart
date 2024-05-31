import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

enum ImagesNames {
  muesli,
  eggSandwish,
  salad,
  salmonEggs,
  tomatoesPesto,
  loadingPlaceholder
}

extension ImagesNamesExtension on ImagesNames {
  String get imageNameString {
    switch (this) {
      case ImagesNames.muesli:
        return 'muesli';
      case ImagesNames.eggSandwish:
        return 'egg sandwish';
      case ImagesNames.salad:
        return 'salad';
      case ImagesNames.salmonEggs:
        return 'salmon eggs';
      case ImagesNames.tomatoesPesto:
        return 'tomatoes pesto';
      case ImagesNames.loadingPlaceholder:
      return 'loading placeholder';
    }
  }

  ImagesPathsSections get section {
    switch (this) {
      case ImagesNames.muesli:
        return ImagesPathsSections.getStarted;
      case ImagesNames.eggSandwish:
        return ImagesPathsSections.getStarted;
      case ImagesNames.salad:
        return ImagesPathsSections.getStarted;
      case ImagesNames.salmonEggs:
        return ImagesPathsSections.getStarted;
      case ImagesNames.tomatoesPesto:
        return ImagesPathsSections.getStarted;
      case ImagesNames.loadingPlaceholder:
        return ImagesPathsSections.extra;
    }
  }
}