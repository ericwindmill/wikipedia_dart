import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' show Router;

class PageSummaryApi {
  Router get router {
    final router =
        Router()..get('/random', (Request _) async {
          final http.Client client = http.Client();
          try {
            final Uri url = Uri.https(
              'en.wikipedia.org',
              '/api/rest_v1/page/random/summary',
            );
            final http.Response response = await client.get(url);
            if (response.statusCode == 200) {
              return Response.ok(
                response.body,
                headers: {'Content-Type': 'application/json'},
              );
            } else {
              return Response.internalServerError();
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
