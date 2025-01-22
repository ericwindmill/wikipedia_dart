part of 'command.dart';

class GetArticleCommand extends Command<String> with Args {
  @override
  List<String> get aliases => ['a'];

  @override
  String get description =>
      'Print an article summary from Wikipedia. If no article name is specified, it prints a random article summary.';

  @override
  String get name => 'article';

  @override
  String? get argDefault => 'random';

  @override
  String get argHelp => '"article title"';

  @override
  bool get argRequired => false;

  @override
  String get argName => 'title';

  @override
  bool validateArgs(List<String>? args) {
    if (!super.validateArgs(args)) {
      return false;
    }

    return true;
  }

  @override
  Stream<String> run({List<String>? args}) async* {
    try {
      Summary summary;
      if ((args != null && args.isNotEmpty) && validateArgs(args)) {
        var articleTitle = args.first.split('=')[1];
        summary = await WikipediaApiClient.getArticleSummary(articleTitle);
      } else {
        summary = await WikipediaApiClient.getRandomArticle();
      }

      yield summary.toString();
    } on HttpException {
      yield ('Unable to fetch article from Wikipedia'.errorText);
    } catch (e, s) {
      yield ('\nUnknown error - $e\n'.red);
      yield (s.toString());
    }
  }
}
