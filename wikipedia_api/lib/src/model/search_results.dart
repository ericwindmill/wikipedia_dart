class SearchResult {
  SearchResult({required this.title, required this.url});
  final String title;
  final String url;
}

class SearchResults {
  SearchResults(this.results, {this.searchTerm});
  final List<SearchResult> results;
  final String? searchTerm;

  static SearchResults fromJson(List<Object?> json) {
    final List<SearchResult> results = <SearchResult>[];
    if (json case [
      final String searchTerm,
      final Iterable<String> articleTitles,
      Iterable<Object?> _,
      final Iterable<String> urls,
    ]) {
      final List<String> titlesList = articleTitles.toList();
      final List<String> urlList = urls.toList();
      for (int i = 0; i < articleTitles.length; i++) {
        results.add(SearchResult(title: titlesList[i], url: urlList[i]));
      }
      return SearchResults(results, searchTerm: searchTerm);
    }
    throw FormatException('Could not deserialize SearchResults, json=$json');
  }

  @override
  String toString() {
    final StringBuffer pretty = StringBuffer();
    for (final SearchResult result in results) {
      pretty.write('${result.url} \n');
    }
    return '\nSearchResults for $searchTerm: \n$pretty';
  }
}
