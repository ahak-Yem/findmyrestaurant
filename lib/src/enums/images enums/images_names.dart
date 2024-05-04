enum ImagesNames {
  muesli
}

extension ImagesNamesExtension on ImagesNames {
  String get imageName {
    switch (this) {
      case ImagesNames.muesli:
        return 'muesli';
    }
  }
}