extension RivePathConverter on String {
  String toRivePath() {
    String imagePath = 'assets/images';
    String riveImagePath = 'assets/rive_images';
    return replaceFirst(imagePath, riveImagePath)
        .replaceFirst('.png', '.riv');
  }
}