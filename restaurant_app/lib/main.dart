import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService()),
            child: const HomePage()),
        RestaurantDetailPage.routeName: (context) =>
            ChangeNotifierProvider<DetailProvider>(
              create: (_) => DetailProvider(apiService: ApiService()),
              child: RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
            )
      },
    );
  }
}
