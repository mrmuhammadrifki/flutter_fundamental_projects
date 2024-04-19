import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late ListRestaurantResult _listRestaurantResult;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurantResult get result => _listRestaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restoran tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantResult = restaurant;
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

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final searchResult = await apiService.searchRestaurant(query);

      if (searchResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Restoran tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _listRestaurantResult = searchResult;
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
}
