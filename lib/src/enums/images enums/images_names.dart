enum ImagesNames {
  muesli,
  tutorial_1
}

extension ImagesNamesExtension on ImagesNames {
  String get imageName {
    switch (this) {
      case ImagesNames.muesli:
        return 'muesli';
      case ImagesNames.tutorial_1:
        return 'tutorial_image 1';
    }
  }
}