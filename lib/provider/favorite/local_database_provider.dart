import 'package:flutter/material.dart';
import 'package:resto_app/data/local/local_database_service.dart';
import 'package:resto_app/data/model/restaurant.dart';

class LocalDatabaseProvider extends ChangeNotifier {
    final LocalDatabaseService _service;

    LocalDatabaseProvider(this._service);

    String _message = "";
    String get message => _message;

    List<Restaurant>? _restaurantList;
    List<Restaurant>? get restaurantList => _restaurantList;

    Restaurant? _restaurant;
    Restaurant? get restaurant => _restaurant;

    Future<void> saveFavoriteResto(Restaurant value) async {
      try {
        final result = await _service.insertItem(value);

        final isError = result == 0;
        if (isError) {
          _message = "Failed to save your favorite restaurant";
        } else {
          _message = "Restaurant is favorited";
        }
      } catch (e) {
        _message = "Failed to favorited your restaurant";
      }
      notifyListeners();
    }

    Future<void> loadAllFavoriteResto() async {
      try {
        _restaurantList = await _service.getAllItems();
        _restaurant = null;
        _message = "All of your favorite restaurant is loaded";
        notifyListeners();
      } catch (e) {
        _message = "Failed to load your all favorite restaurant ";
        notifyListeners();
      }
    }

    Future<void> loadFavoriteRestoById(String id) async {
      try {
        _restaurant = await _service.getItemById(id);
        _message = "Your favorite restaurant is loaded";
        notifyListeners();
      } catch (e) {
        _message = "Failed to load your favorite restaurant";
        notifyListeners();
      }
    }

    Future<void> removeFavoriteRestoById(String id) async {
      try {
        await _service.removeItem(id);

        _message = "Your favorite restaurant is removed";
        notifyListeners();
      } catch (e) {
        _message = "Failed to remove your favorite restaurant";
        notifyListeners();
      }
    }

    bool checkItemFavorite(String id) {
      final isSameFavoriteRestaurant = _restaurant?.id == id;
      return isSameFavoriteRestaurant;
    }
}