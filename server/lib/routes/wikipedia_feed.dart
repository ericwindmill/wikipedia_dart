import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class WikipediaFeedApi {
  Router get router {
    final router =
        Router()..get('/', (Request _) async {
          final DateTime date = DateTime.now();
          final int year = date.year;
          final String month = toStringWithPad(date.month);
          final String day = toStringWithPad(date.day);
          final http.Client client = http.Client();
          try {
            final Uri url = Uri.https(
              'en.wikipedia.org',
              '/api/rest_v1/feed/featured/$year/$month/$day',
            );
            final http.Response wikiResponse = await client.get(url);
            if (wikiResponse.statusCode == 200) {
              return Response.ok(
                wikiResponse.body,
                headers: {'Content-Type': 'application/json'},
              );
            } else if (wikiResponse.statusCode == 404) {
              return Response.notFound(
                '[WikipediaDart.getWikipediaFeed] '
                'statusCode=${wikiResponse.statusCode}, '
                'body=${wikiResponse.body}',
              );
            }
          } on HttpException catch (error) {
            // TODO(ewindmill): log
            throw HttpException('Unexpected error - $error');
          } finally {
            client.close();
          }
        });

    return router;
  }
}
