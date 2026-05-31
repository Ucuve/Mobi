import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/article.dart';

Future<List<Article>> getArticleByTitle(String title) async {
  final client = http.Client();
  try {
    final url = Uri.https('en.wikipedia.org', '/w/api.php', {
      'action': 'query',
      'format': 'json',
      'titles': title.trim(),
      'prop': 'extracts',
      'explaintext': '',
    });
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, Object?> jsonData = jsonDecode(response.body);
      return Article.listFromJson(jsonData);
    } else {
      throw HttpException('Failed to fetch article: $title');
    }
  } finally {
    client.close();
  }
}