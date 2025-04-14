import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/provider/favorite/favorite_icon_provider.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';

class FavoriteIcon extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIcon({super.key, required this.restaurant});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {

  @override
  void initState() {

    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadFavoriteRestoById(widget.restaurant.id);
      final value = localDatabaseProvider.checkItemFavorite(widget.restaurant.id);

      favoriteIconProvider.isFavorite = value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorite;

        if (!isFavorited) {
          localDatabaseProvider.saveFavoriteResto(widget.restaurant);
        } else {
          localDatabaseProvider.removeFavoriteRestoById(widget.restaurant.id);
        }
        favoriteIconProvider.isFavorite = !isFavorited;
        localDatabaseProvider.loadAllFavoriteResto();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorite
            ? Icons.favorite
            : Icons.favorite_border,
      ),
    );
  }
}
