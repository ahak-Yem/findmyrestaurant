enum ImagesPathsSections {
  getStarted
}

extension ImagesPathsSectionsExtension on ImagesPathsSections {
  String get sectionString {
    switch (this) {
      case ImagesPathsSections.getStarted:
        return 'getStarted';
    }
  }
}