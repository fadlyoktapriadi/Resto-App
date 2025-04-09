
import 'package:resto_app/data/model/customer_review.dart';

sealed class RestoReviewResultState{}

class RestoReviewNoneState extends RestoReviewResultState{}

class RestoReviewLoadingState extends RestoReviewResultState{}

class RestoReviewErrorState extends RestoReviewResultState{
  final String message;

  RestoReviewErrorState(this.message);
}

class RestoReviewLoadedState extends RestoReviewResultState{
  final List<CustomerReview> customerReviews;

  RestoReviewLoadedState(this.customerReviews);
}