
import 'package:flutter/cupertino.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/helper/resto_search_result_state.dart';

class RestoSearchProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestoSearchProvider(this._apiService);

  RestoSearchResultState _resultState = RestoSearchNoneState();

  RestoSearchResultState get resultState => _resultState;

  Future<void> fetchRestaurantSearch(String query) async {
    if (query.isEmpty) {
      _resultState = RestoSearchNoneState();
      notifyListeners();
      return;
    }

    try {
      _resultState = RestoSearchLoadingState();
      notifyListeners();

      final result = await _apiService.getSearchRestaurant(query);

      if (result.error || result.restaurants.isEmpty) {
        _resultState = RestoSearchNoneState();
      } else {
        _resultState = RestoSearchLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestoSearchErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }

}