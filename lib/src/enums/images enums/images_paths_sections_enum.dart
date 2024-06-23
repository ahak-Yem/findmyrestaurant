enum ImagesPathsSections {
  getStarted,
  icons,
  extra
}

extension ImagesPathsSectionsExtension on ImagesPathsSections {
  String get sectionString {
    switch (this) {
      case ImagesPathsSections.getStarted:
        return 'getStarted';
      case ImagesPathsSections.icons:
        return 'icons';
      case ImagesPathsSections.extra:
        return 'extra';
    }
  }
}