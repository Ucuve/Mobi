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
    final List<SearchResult> results = [];
    if (json case [String searchTerm, Iterable articleTitles, Iterable _, Iterable urls]) {
      final titlesList = articleTitles.toList();
      final urlList = urls.toList();
      for (int i = 0; i < articleTitles.length; i++) {
        results.add(SearchResult(title: titlesList[i], url: urlList[i]));
      }
      return SearchResults(results, searchTerm: searchTerm);
    }
    throw FormatException('Could not deserialize SearchResults, json=$json');
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    for (final result in results) {
      buffer.write('${result.url}\n');
    }
    return '\nSearchResults for $searchTerm:\n$buffer';
  }
}