
import 'package:resto_app/data/model/restaurant.dart';

sealed class RestoSearchResultState{}

class RestoSearchNoneState extends RestoSearchResultState{}

class RestoSearchLoadingState extends RestoSearchResultState{}

class RestoSearchErrorState extends RestoSearchResultState{
  final String message;

  RestoSearchErrorState(this.message);
}

class RestoSearchLoadedState extends RestoSearchResultState{
  final List<Restaurant> restaurantList;

  RestoSearchLoadedState(this.restaurantList);
}