enum ImagesNames {
  muesli,
  eggSandwish,
  salad,
  salmonEggs,
  tomatoesPesto
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
    }
  }
}