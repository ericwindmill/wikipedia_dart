/// Contains models for objects from the Wikipedia API and Wikimedia API, as
/// well as classes [WikipediaApiClient] and [WikimediaApiClient], which
/// expose static methods that fetch select data from Wikipedia's APIs
library;

import 'package:wikipedia_api/wikipedia_api.dart'
    show WikimediaApiClient, WikipediaApiClient;

export 'src/model/article.dart';
export 'src/model/event_type.dart';
export 'src/model/feed.dart';
export 'src/model/image.dart';
export 'src/model/on_this_day_event.dart';
export 'src/model/on_this_day_timeline.dart';
export 'src/model/original_image.dart';
export 'src/model/search_results.dart';
export 'src/model/summary.dart';
export 'src/model/title_set.dart';
export 'src/resources/strings.dart';
export 'src/util.dart';
export 'src/wikimedia_api_client.dart';
export 'src/wikipedia_open_api_client.dart';
