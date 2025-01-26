/// Simple Localizations similar to
/// https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#an-alternative-class-for-the-apps-localized-resources
class AppStrings {
  static const Map<String, String> _strings =
      <String, String>{
        'featuredArticle': 'Featured article',
        'today': 'Today',
        'onThisDay': 'On this day',
      };

  // If string for "label" does not exist, will show "[LABEL]"
  static String _get(String label) =>
      _strings[label] ?? '[${label.toUpperCase()}]';

  static String get todaysFeaturedArticle =>
      _get('featuredArticle');
  static String get today => _get('today');
  static String get onThisDay => _get('onThisDay');
}
