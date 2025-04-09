import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/helper/resto_detail_result_state.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/screen/detail/body_detail_screen.dart';

class DetailScreen extends StatefulWidget {

  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask((){
      context.read<RestoDetailProvider>().fetchDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestoDetailProvider>(
        builder: (context, value, child){
          return switch(value.resultState){
            RestoDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestoDetailLoadedState(restaurant: var restaurant) =>
                BodyDetailScreen(restaurant: restaurant),
            RestoDetailErrorState(message: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
