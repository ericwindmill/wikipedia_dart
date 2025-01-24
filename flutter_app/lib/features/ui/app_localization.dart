/// Simple Localizations similar to
/// https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#an-alternative-class-for-the-apps-localized-resources
class AppStrings {
  static const _strings = <String, String>{
    'todaysFeaturedArticle': "Today's featured article",
  };

  // If string for "label" does not exist, will show "[LABEL]"
  static String _get(String label) =>
      _strings[label] ?? '[${label.toUpperCase()}]';

  static String get todaysFeaturedArticle => _get('todaysFeaturedArticle');
}
