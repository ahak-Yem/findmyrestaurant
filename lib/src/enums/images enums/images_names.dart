import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';

enum ImagesNames {
  muesli,
  eggSandwish,
  salad,
  salmonEggs,
  tomatoesPesto,
  loadingPlaceholder,
  noImagePlaceholder,
  arrowPrimary,
  arrowWhite,
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
      case ImagesNames.noImagePlaceholder:
        return 'no image placeholder';
      case ImagesNames.arrowPrimary:
        return 'arrow_primary';
      case ImagesNames.arrowWhite:
        return 'arrow_white';
    }
  }

  ImagesPathsSections get section {
    switch (this) {
      case ImagesNames.muesli:
      case ImagesNames.eggSandwish:
      case ImagesNames.salad:
      case ImagesNames.salmonEggs:
      case ImagesNames.tomatoesPesto:
        return ImagesPathsSections.getStarted;
      case ImagesNames.loadingPlaceholder:
      case ImagesNames.noImagePlaceholder:
        return ImagesPathsSections.extra;
      case ImagesNames.arrowPrimary:
      case ImagesNames.arrowWhite:
        return ImagesPathsSections.icons;

    }
  }
}