import 'dart:ui';

class OnboardPageModel {
  final Color primeColor;
  final Color secondColor;
  final Color thirdColor;
  final int pageNumber;
  final String imagePath;
  final String secondPath;
  final String thirdPath;
  final String caption;
  final String message;
  final String longMessage;

  OnboardPageModel(
      this.primeColor,
      this.secondColor,
      this.thirdColor,
      this.pageNumber,
      this.imagePath,
      this.secondPath,
      this.thirdPath,
      this.caption,
      this.message,
      this.longMessage);
}
