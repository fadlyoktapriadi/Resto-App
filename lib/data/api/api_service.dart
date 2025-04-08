import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/detail_restaurant_response.dart';
import 'package:resto_app/data/model/restaurant_list_response.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));
      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on http.ClientException {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
      if (response.statusCode == 200) {
        return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on http.ClientException {
      throw Exception('Failed to connect to the server');
    }
  }
}