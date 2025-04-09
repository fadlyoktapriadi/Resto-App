import 'dart:convert';

import 'customer_review.dart';

ReviewDetailResponse reviewDetailResponseFromJson(String str) => ReviewDetailResponse.fromJson(json.decode(str));

String reviewDetailResponseToJson(ReviewDetailResponse data) => json.encode(data.toJson());

class ReviewDetailResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  ReviewDetailResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewDetailResponse.fromJson(Map<String, dynamic> json) => ReviewDetailResponse(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}