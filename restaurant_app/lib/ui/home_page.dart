import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant App'),
        ),
        body: const RestaurantListPage());
  }
}
