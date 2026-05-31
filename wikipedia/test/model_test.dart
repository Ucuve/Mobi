import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:wikipedia/src/model/article.dart';
import 'package:wikipedia/src/model/search_results.dart';
import 'package:wikipedia/src/model/summary.dart';

const String dartLangSummaryJson = './test/test_data/dart_lang_summary.json';
const String catExtractJson = './test/test_data/cat_extract.json';
const String openSearchResponse = './test/test_data/open_search_response.json';

void main() {
  group('deserialize example JSON responses from wikipedia API', () {
    test('deserialize Dart Programming Language page summary', () async {
      final String input = await File(dartLangSummaryJson).readAsString();
      final Map<String, Object?> map = jsonDecode(input) as Map<String, Object?>;
      final Summary summary = Summary.fromJson(map);
      expect(summary.titles.canonical, 'Dart_(programming_language)');
    });

    test('deserialize Cat article into an Article object', () async {
      final String input = await File(catExtractJson).readAsString();
      final Map<String, Object?> map = jsonDecode(input) as Map<String, Object?>;
      final List<Article> articles = Article.listFromJson(map);
      expect(articles.first.title.toLowerCase(), 'cat');
    });

    test('deserialize Open Search results into SearchResults object', () async {
      final String input = await File(openSearchResponse).readAsString();
      final List<Object?> list = jsonDecode(input) as List<Object?>;
      final SearchResults results = SearchResults.fromJson(list);
      expect(results.results.length, greaterThan(1));
    });
  });
}