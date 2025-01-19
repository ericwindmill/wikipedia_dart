// import 'package:shared/wikipedia_api.dart';
//
// import 'app.dart';
//
// Future setTimeout(callback, [int duration = 1000]) async {
//   return await Future.delayed(Duration(milliseconds: duration), callback);
// }
//
// Future<void> delayedPrint(String text, {int duration = 200}) async {
//   await setTimeout(() => print(text), duration);
// }
//
// /// [duration] defines how much time there will be between each line print (in milliseconds).
// Future<void> printByLine(List<String> lines, {int duration = 100}) async {
//   for (var l in lines) {
//     await delayedPrint(l, duration: duration);
//   }
// }
//
// void prettyPrintSummary(Summary summary) async {
//   await delayedPrint('=== ${summary.titles.normalized} ===');
//   await printByLine(summary.extract.splitByLength(80));
//   await delayedPrint('Read more: ${summary.url}');
//   print(' ');
// }
//
// void prettyPrintArticle(Article article) async {
//   await delayedPrint('=== ${article.title} ===');
//   print('');
//   var lines = article.extract.split('\n');
//   for (var l in lines) {
//     await printByLine(l.splitByLength(80));
//   }
// }
//
// Future<void> prettyPrintOnThisDayEvent(OnThisDayEvent event) async {
//   await delayedPrint('=== ${event.year} ===');
//   var words = event.text.split(' ');
//   var lineLength = normalLineLength;
//   var str = StringBuffer();
//   for (var word in words) {
//     if ((lineLength - word.length + 1) > 0) {
//       str.write('$word ');
//       lineLength -= word.length;
//     } else {
//       str.write('\n');
//       lineLength = 80;
//     }
//   }
//   await printByLine(str.toString().split('\n'));
// }
//
// extension on String {
//   List<String> splitByLength(int length, {bool ignoreEmpty = false}) {
//     List<String> pieces = [];
//
//     for (int i = 0; i < this.length; i += length) {
//       int offset = i + length;
//       String piece = substring(i, offset >= this.length ? this.length : offset);
//
//       if (ignoreEmpty) {
//         piece = piece.replaceAll(RegExp(r'\s+'), '');
//       }
//
//       pieces.add(piece);
//     }
//     return pieces;
//   }
// }
