import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/search_results.dart';

Future<SearchResults> search(String searchTerm) async {
  final client = http.Client();
  try {
    final url = Uri.https('en.wikipedia.org', '/w/api.php', {
      'action': 'opensearch',
      'format': 'json',
      'search': searchTerm,
    });
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final List<Object?> jsonData = jsonDecode(response.body);
      return SearchResults.fromJson(jsonData);
    } else {
      throw HttpException('Search failed for: $searchTerm');
    }
  } finally {
    client.close();
  }
}