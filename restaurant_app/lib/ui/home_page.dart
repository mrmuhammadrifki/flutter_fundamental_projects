import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/widget/component_search_bar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Kita'),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ComponentSearchBar(),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: RestaurantListPage(),
          ),
        ],
      ),
    );
  }
}
