import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant.dart';

class RestoCard extends StatelessWidget {

  final Restaurant restaurant;
  final Function() onTap;

  const RestoCard({super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: onTap,
        child: Card(
          elevation: 1.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                        fit: BoxFit.cover,
                        height: 120.0,
                        errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/error_image.png'),
                        ),
                      ),
                    ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                               overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                                style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Card(
                            elevation: 1.0,
                            color: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary, // Set the border color
                                width: 1.0, // Set the border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14.0,
                                  ),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 14.0,
                          ),
                          const SizedBox(width: 4), // Add some space between icon and text
                          Text(
                            restaurant.city,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ]
                      ),
                      const SizedBox(height: 4),
                      Text(
                        restaurant.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

