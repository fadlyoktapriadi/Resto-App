import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/local/local_database_service.dart';
import 'package:resto_app/provider/detail/resto_review_provider.dart';
import 'package:resto_app/provider/favorite/favorite_icon_provider.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/provider/search/query_search_provider.dart';
import 'package:resto_app/provider/search/resto_search_provider.dart';
import 'package:resto_app/provider/setting/SharedPreferecesProvider.dart';
import 'package:resto_app/screen/detail/detail_screen.dart';
import 'package:resto_app/screen/favorite/favorite_screen.dart';
import 'package:resto_app/screen/home/home_screen.dart';
import 'package:resto_app/screen/navigation_route.dart';
import 'package:resto_app/screen/setting/setting_screen.dart';
import 'package:resto_app/styles/theme/resto_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/local/shared_preferences_service.dart';
import 'provider/detail/resto_detail_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

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
        ChangeNotifierProvider(
          create: (context) => RestoReviewProvider(ApiService()),
        ),
        Provider(create: (context) => LocalDatabaseService()
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteIconProvider(),
        ),
        Provider(
          create: (context) => SharedPreferencesService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          ),
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

    final sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context);

    return MaterialApp(
      theme: RestoTheme.lightTheme,
      darkTheme: RestoTheme.darkTheme,
      themeMode: sharedPreferencesProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(id: ModalRoute.of(context)!.settings.arguments as String),
        NavigationRoute.favoriteRoute.name: (context) => const FavoriteScreen(),
        NavigationRoute.settingRoute.name: (context) => const SettingScreen(),
      },
    );
  }
}