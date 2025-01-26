import '../../wikipedia_api.dart';

class WikipediaFeed {
  WikipediaFeed({
    required this.todaysFeaturedArticle,
    required this.onThisDayTimeline,
    required this.mostRead,
    required this.imageOfTheDay,
  });
  final Summary? todaysFeaturedArticle;
  final List<OnThisDayEvent>? onThisDayTimeline;
  final List<Summary>? mostRead;
  final WikipediaImage? imageOfTheDay;

  static WikipediaFeed fromJson(Map<String, Object?> json) {
    final Summary? featured =
        json.containsKey('tfa')
            ? Summary.fromJson(
              json['tfa']! as Map<String, Object?>,
            )
            : null;
    final List<OnThisDayEvent>? timeline =
        json.containsKey('onthisday')
            ? (json['onthisday']
                    as List<Map<String, Object?>>?)
                ?.map(
                  (Map<String, Object?> e) =>
                      OnThisDayEvent.fromJson(
                        e,
                        EventType.birthday,
                      ),
                )
                .toList()
            : null;
    final WikipediaImage? image =
        json.containsKey('image')
            ? WikipediaImage.fromJson(
              json['image']! as Map<String, Object?>,
            )
            : null;

    final Map<String, Object?>? mostReadJson =
        json.containsKey('mostread')
            ? (json['mostread']! as Map<String, Object?>)
            : null;
    List<Summary>? mostRead;
    if (mostReadJson != null) {
      mostRead =
          (mostReadJson['articles']! as List<Object?>)
              .map(
                (Object? article) => Summary.fromJson(
                  article! as Map<String, Object?>,
                ),
              )
              .toList();
    }

    return WikipediaFeed(
      todaysFeaturedArticle: featured,
      onThisDayTimeline: timeline,
      mostRead: mostRead,
      imageOfTheDay: image,
    );
  }
}
