import 'package:resto_app/data/model/restaurant.dart';

sealed class RestoListResultState{}

class RestoListNoneState extends RestoListResultState{}

class RestoListLoadingState extends RestoListResultState{}

class RestoListErrorState extends RestoListResultState{
  final String message;

  RestoListErrorState(this.message);
}

class RestoListLoadedState extends RestoListResultState{
  final List<Restaurant> restaurantList;

  RestoListLoadedState(this.restaurantList);
}