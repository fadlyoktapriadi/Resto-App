import 'package:flutter/material.dart';
import 'package:resto_app/screen/home/resto_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return resto_card();
                  },
                ),
              ),
            ],
        ),
      ),
      ),
    );
  }
}
