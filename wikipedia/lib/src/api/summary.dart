import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/summary.dart';

Future<Summary> getRandomArticleSummary() async {
  final client = http.Client();
  try {
    final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/random/summary');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, Object?> jsonData = jsonDecode(response.body);
      return Summary.fromJson(jsonData);
    } else {
      throw HttpException('Failed to fetch random article');
    }
  } finally {
    client.close();
  }
}

Future<Summary> getArticleSummaryByTitle(String articleTitle) async {
  final client = http.Client();
  try {
    final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$articleTitle');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, Object?> jsonData = jsonDecode(response.body);
      return Summary.fromJson(jsonData);
    } else {
      throw HttpException('Failed to fetch article: $articleTitle');
    }
  } finally {
    client.close();
  }
}