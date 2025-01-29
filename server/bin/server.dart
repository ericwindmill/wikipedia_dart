// ignore_for_file: avoid_print

import 'dart:io';

import 'package:server/routes/wikipedia_feed.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router =
    Router()
      ..get('/', () => print('alive!'))
      ..mount('/feed', WikipediaFeedApi().router.call);

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8888');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
