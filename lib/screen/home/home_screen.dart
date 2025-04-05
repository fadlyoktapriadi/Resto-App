import 'package:flutter/material.dart';

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
              Text(
                'Resto App.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
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
            ],
        ),
      ),
      ),
    );
  }
}
