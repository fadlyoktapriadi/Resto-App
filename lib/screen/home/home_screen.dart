import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/helper/resto_list_result_state.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/screen/home/resto_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask((){
      context.read<RestoListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 12), child:
              Text(
                'Resto App.',
                style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 8),
              SearchBar(
                hintText: 'Search Restaurant..',
                leading: const Icon(Icons.search),
                onChanged: (value) {
                  // Handle search input
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Popular Restaurants',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<RestoListProvider>(
                    builder: (context, value, child) {
                      return switch (value.resultState) {
                        RestoListNoneState() => const Center(
                            child: Text('No Data'),
                          ),
                        RestoListLoadingState() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        RestoListErrorState(message: var message) => Center(
                            child: Text(message),
                          ),
                        RestoListLoadedState(restaurantList: var restaurantList) =>
                            ListView.builder(
                            itemCount: restaurantList.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurantList[index];

                              return RestoCard(
                                restaurant: restaurant,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail',
                                    arguments: restaurant.id,
                                  );
                                },
                              );
                            },
                        ),
                      };
                    }
                )
                ),
            ],
        ),
      ),
      ),
    );
  }
}
