import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailProvider({required this.apiService});

  late DetailRestaurantResult _detailRestaurant;
  late List<CustomerReview> _customerReview;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResult get detailResult => _detailRestaurant;

  List<CustomerReview> get customerReview => _customerReview;

  ResultState get state => _state;

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;

      final detailResult = await apiService.getDetailRestaurant(id);

      if (detailResult.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Restoran tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _detailRestaurant = detailResult;
        _customerReview = detailResult.restaurant.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        _message = 'Tidak ada koneksi internet. Silakan periksa koneksi Anda.';
      } else {
        _message = 'Error --> $e';
      }
    }
  }

  Future<dynamic> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.addReview(id, name, review);

      _state = ResultState.hasData;
      _customerReview = response.customerReviews as List<CustomerReview>;
    } catch (e) {
      _state = ResultState.error;
      if (e is SocketException) {
        _message = 'Tidak ada koneksi internet. Silakan periksa koneksi Anda.';
      } else {
        _message = 'Error --> $e';
      }
    } finally {
      notifyListeners();
    }
  }
}
