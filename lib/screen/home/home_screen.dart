import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/helper/resto_list_result_state.dart';
import 'package:resto_app/helper/resto_search_result_state.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/provider/search/query_search_provider.dart';
import 'package:resto_app/provider/search/resto_search_provider.dart';
import 'package:resto_app/screen/home/resto_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestoListProvider>().fetchRestaurantList();
    });

    _searchController.addListener(() {
      final query = _searchController.text;
      context.read<SearchQueryProvider>().updateQuery(query);

      if (query.isNotEmpty) {
        context.read<RestoSearchProvider>().fetchRestaurantSearch(query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final searchQuery = context.watch<SearchQueryProvider>().searchQuery;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Resto App.',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/favorite');
                        },
                        icon: const Icon(Icons.favorite),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              SearchBar(
                controller: _searchController,
                hintText: 'Search Restaurant...',
                leading: const Icon(Icons.search),
              ),
              const SizedBox(height: 20),
              Text(
                searchQuery.isEmpty
                    ? 'Popular Restaurants'
                    : 'Search Results',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: searchQuery.isEmpty
                    ? Consumer<RestoListProvider>(
                  builder: (context, value, child) {
                    return switch (value.resultState) {
                      RestoListNoneState() => const Center(
                        child: Text('No Data Restaurant Found'),
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
                  },
                )
                    : Expanded(
                  child: Consumer<RestoSearchProvider>(
                    builder: (context, provider, child) {
                      return switch (provider.resultState) {
                        RestoSearchNoneState() => const Center(
                          child: Text('No Data Restaurant Found'),
                        ),
                        RestoSearchLoadingState() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        RestoSearchErrorState(message: var message) => Center(
                          child: Text(message),
                        ),
                        RestoSearchLoadedState(restaurantList: var restaurantList) =>
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
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}