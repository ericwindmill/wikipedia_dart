// for OPTIONS (preflight) requests just add headers and an empty response
import 'package:shelf/shelf.dart';

const Map<String, String> headers = {
  'Access-Control-Allow-Origin': '*',
  'Content-Type': 'text/json',
};

Response? options(Request request) =>
    (request.method == 'OPTIONS') ? Response.ok(null, headers: headers) : null;

Response cors(Response response) => response.change(headers: headers);

final Middleware fixCORS = createMiddleware(
  requestHandler: options,
  responseHandler: cors,
);
