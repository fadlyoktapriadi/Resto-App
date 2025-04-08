import 'package:resto_app/data/model/detail_restaurant_response.dart';

sealed class RestoDetailResultState{}

class RestoDetailNoneState extends RestoDetailResultState{}

class RestoDetailLoadingState extends RestoDetailResultState{}

class RestoDetailErrorState extends RestoDetailResultState{
  final String message;
  RestoDetailErrorState(this.message);
}

class RestoDetailLoadedState extends RestoDetailResultState{
  final DetailRestaurant restaurant;
  RestoDetailLoadedState(this.restaurant);
}