import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurantResult> getListRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<ListRestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<ReviewResult> addReview(String id, String name, String review) async {
    final Uri url = Uri.parse('$_baseUrl/review');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> requestBody = {
      'id': id,
      'name': name,
      'review': review,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      return ReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
