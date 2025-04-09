import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/helper/resto_detail_result_state.dart';

class RestoDetailProvider with ChangeNotifier {
  final ApiService _apiService;

  RestoDetailProvider(this._apiService);

  RestoDetailResultState _resultState = RestoDetailNoneState();

  RestoDetailResultState get resultState => _resultState;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _resultState = RestoDetailLoadingState();
      notifyListeners();

      final detailRestaurant = await _apiService.getDetailRestaurant(id);
      if (detailRestaurant.error) {
        _resultState = RestoDetailErrorState(detailRestaurant.message);
      } else {
        _resultState = RestoDetailLoadedState(detailRestaurant.restaurant);
      }
    } catch (e) {
      _resultState = RestoDetailErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }

}
