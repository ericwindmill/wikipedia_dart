import 'package:flutter/widgets.dart';
import 'package:flutter_app/ui/breakpoint.dart';

const String serverHost = 'localhost';
const String serverPort = '8080';

const String serverUri = '$serverHost:$serverPort';

extension Adaptive on BuildContext {
  bool get isCupertino => Breakpoint.isCupertino(this);
}
