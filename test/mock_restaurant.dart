import 'package:resto_app/data/model/customer_review.dart';
import 'package:resto_app/data/model/detail_restaurant_response.dart';
import 'package:resto_app/data/model/restaurant.dart';

final mockRestaurantsList = [
  Restaurant(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    pictureId: "14",
    city: "Medan",
    rating: 4.2,
  ),
  Restaurant(
    id: "s1knt6za9kkfw1e867",
    name: "Kafe Kita",
    description: "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
    pictureId: "25",
    city: "Gorontalo",
    rating: 4.0,
  ),
];

final mockRestaurantDetail = DetailRestaurant(
  id: "rqdv5juczeskfw1e867",
  name: "Melting Pot",
  description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
  city: "Medan",
  address: "Jln. Pandeglang no 19",
  pictureId: "14",
  categories: [
    Category(name: "Italia"),
    Category(name: "Modern"),
  ],
  menus: Menus(
    foods: [
      Category(name: "Paket rosemary"),
      Category(name: "Toastie salmon"),
    ],
    drinks: [
      Category(name: "Es krim"),
      Category(name: "Sirup"),
    ],
  ),
  rating: 4.2,
  customerReviews: [
    CustomerReview(
      name: "Ahmad",
      review: "Tidak rekomendasi untuk pelajar!",
      date: "13 November 2019",
    ),
  ],
);