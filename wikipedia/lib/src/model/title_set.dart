class TitlesSet {
  TitlesSet({required this.canonical, required this.normalized, required this.display});
  final String canonical;
  final String normalized;
  final String display;

  static TitlesSet fromJson(Map<String, Object?> json) {
    if (json case {
      'canonical': final String canonical,
      'normalized': final String normalized,
      'display': final String display,
    }) {
      return TitlesSet(canonical: canonical, normalized: normalized, display: display);
    }
    throw FormatException('Could not deserialize TitleSet, json=$json');
  }

  @override
  String toString() => 'TitlesSet[canonical=$canonical, normalized=$normalized, display=$display]';
}