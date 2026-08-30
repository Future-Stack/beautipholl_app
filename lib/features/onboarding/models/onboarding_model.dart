class OnboardingModel {
  const OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageTop,
    required this.imageRotation,
    required this.titleWidth,
    required this.greekLeft,
    required this.greekTop,
    required this.showSkip,
  });

  final String image;
  final String title;
  final String subtitle;
  final double imageWidth;
  final double imageHeight;
  final double imageTop;
  final double imageRotation;
  final double titleWidth;
  final double greekLeft;
  final double greekTop;
  final bool showSkip;
}
