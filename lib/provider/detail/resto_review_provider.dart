import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/helper/resto_review_result_state.dart';

class RestoReviewProvider with ChangeNotifier {
  final ApiService _apiService;

  RestoReviewProvider(this._apiService);

  RestoReviewResultState _resultState = RestoReviewNoneState();

  RestoReviewResultState get resultState => _resultState;

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = RestoReviewLoadingState();

      final addReview = await _apiService.postReview(id, name, review);
      if (addReview.error) {
        _resultState = RestoReviewErrorState(addReview.message);
      } else {
        _resultState = RestoReviewLoadedState(addReview.customerReviews);
      }
    } catch (e) {
      throw Exception('Failed to add review: $e');
    } finally {
      notifyListeners();
    }
  }
}
