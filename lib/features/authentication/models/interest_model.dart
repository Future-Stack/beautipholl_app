class InterestModel {
  const InterestModel({
    required this.id,
    required this.label,
    required this.icon,
    this.selected = false,
  });

  final String id;
  final String label;
  final String icon;
  final bool selected;
}
