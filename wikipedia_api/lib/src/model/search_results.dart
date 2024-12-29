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
    final results = <SearchResult>[];
    if (json case [
      String searchTerm,
      Iterable articleTitles,
      Iterable _,
      Iterable urls,
    ]) {
      var titlesList = articleTitles.toList();
      var urlList = urls.toList();
      for (var i = 0; i < articleTitles.length; i++) {
        results.add(SearchResult(title: titlesList[i], url: urlList[i]));
      }
      return SearchResults(results, searchTerm: searchTerm);
    }
    throw FormatException('Could not deserialize SearchResults, json=$json');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResults &&
          runtimeType == other.runtimeType &&
          results == other.results;

  @override
  int get hashCode => results.hashCode;

  @override
  String toString() {
    var pretty = '';
    for (var result in results) {
      pretty += '${result.url} \n';
    }
    return 'SearchResults: \n $pretty';
  }
}
