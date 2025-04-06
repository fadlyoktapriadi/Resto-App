import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/helper/resto_list_result_state.dart';

class RestoListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestoListProvider(this._apiService);

  RestoListResultState _resultState = RestoListNoneState();

  RestoListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestoListLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantList();

      if (result.error) {
        _resultState = RestoListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestoListLoadedState(result.restaurants);
        notifyListeners();
      }
    } catch (e) {
      _resultState = RestoListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
