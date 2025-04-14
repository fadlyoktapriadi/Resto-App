import 'package:flutter/material.dart';
import 'package:resto_app/data/model/detail_restaurant_response.dart';
import 'package:resto_app/screen/detail/item_card_detail.dart';
import 'package:resto_app/screen/detail/review_detail.dart';

class BodyDetailScreen extends StatelessWidget {

  final DetailRestaurant restaurant;

  const BodyDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
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
                          restaurant.name,
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
                                        restaurant.city,
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
                                        restaurant.rating.toString(),
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
                                    restaurant.address,
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
                        children: restaurant.categories.map((category){
                          return ItemCardDetail(label: category.name);
                        }).toList()
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
                        children: restaurant.menus.foods.map((food){
                          return ItemCardDetail(label: food.name);
                        }).toList()
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
                        children: restaurant.menus.drinks.map((drink){
                          return ItemCardDetail(label: drink.name);
                        }).toList()
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
                    child: Text(restaurant.description,
                      style: Theme.of(context).textTheme.bodyMedium,
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

                  ReviewDetail(customerReviews: restaurant.customerReviews),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 30,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50), // Ensures the ripple effect is circular
                  onTap: () {
                    Navigator.pop(context, '/');
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 30,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50), // Ensures the ripple effect is circular
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite');
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
