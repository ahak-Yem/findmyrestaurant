enum ImagesPathsSections {
  getStarted,
  tutorial
}

extension ImagesPathsSectionsExtension on ImagesPathsSections {
  String get sectionString {
    switch (this) {
      case ImagesPathsSections.getStarted:
        return 'getStarted';
      case ImagesPathsSections.tutorial:
        return 'tutorial';
    }
  }
}