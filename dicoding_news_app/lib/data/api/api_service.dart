import 'dart:convert';

import 'package:dicoding_news_app/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = 'b72c964d236e4845aacd283c13bafaca';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse("${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));

    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}