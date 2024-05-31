enum ImagesPathsSections {
  getStarted,
  extra
}

extension ImagesPathsSectionsExtension on ImagesPathsSections {
  String get sectionString {
    switch (this) {
      case ImagesPathsSections.getStarted:
        return 'getStarted';
      case ImagesPathsSections.extra:
        return 'extra';
    }
  }
}