import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';
import 'package:resto_app/screen/home/resto_card.dart';
import 'package:resto_app/screen/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    Future.microtask((){
      context.read<LocalDatabaseProvider>().loadAllFavoriteResto();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Favorite Restaurant",
                      style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12,),
                Expanded(
                  child: Consumer<LocalDatabaseProvider>(
                    builder: (context, value, child) {
                      final favoriteList = value.restaurantList ?? [];

                      return switch(favoriteList.isNotEmpty){
                        true =>
                            ListView.builder(
                                itemCount: favoriteList.length,
                                itemBuilder: (context, index) {
                                  final Restaurant restaurant = favoriteList[index];
                                  return RestoCard(restaurant: restaurant, onTap: () {
                                    Navigator.pushNamed(
                                        context, NavigationRoute.detailRoute.name,
                                        arguments: restaurant.id);
                                  });
                                }
                            ),
                        _ =>
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No Bookmarked"),
                            ],
                          ),
                        ),
                      };
                    },
                  )
                )
              ],
            ),
          )
      ),
    );
  }
}
