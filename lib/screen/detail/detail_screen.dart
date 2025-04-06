import 'package:flutter/material.dart';

// final _scrollController = ScrollController();

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/large/15',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            ListView(
              children: [
                const SizedBox(height: 210),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text(
                              "Melting Pot",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_city,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Jakarta",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.labelLarge,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "4.5",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.labelLarge,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Jln. Pandeglang no 19",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Category',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CategoryCard(category: 'Italia'),
                              CategoryCard(category: 'Modern'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Foods',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CategoryCard(category: 'Paket rosemary'),
                              CategoryCard(category: 'Toastie salmon'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CategoryCard(category: 'Es krim'),
                              CategoryCard(category: 'Sirup'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Reviews',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Review',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                    ),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3, // Replace with the actual number of reviews
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reviewer Name $index', // Replace with actual reviewer name
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'This is a review comment. It is very insightful and helpful.', // Replace with actual review comment
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Center(
          child: Text(category, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
