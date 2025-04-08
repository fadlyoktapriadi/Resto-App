import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/provider/search/query_search_provider.dart';
import 'package:resto_app/provider/search/resto_search_provider.dart';
import 'package:resto_app/screen/detail/detail_screen.dart';
import 'package:resto_app/screen/home/home_screen.dart';
import 'package:resto_app/screen/navigation_route.dart';
import 'package:resto_app/styles/theme/resto_theme.dart';

import 'provider/detail/resto_detail_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestoListProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoDetailProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoSearchProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchQueryProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: RestoTheme.lightTheme,
      darkTheme: RestoTheme.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(id: ModalRoute.of(context)!.settings.arguments as String)
      },
    );
  }
}