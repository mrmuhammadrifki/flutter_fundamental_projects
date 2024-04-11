import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_response_model.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.pictureId,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.city,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Top Drinks',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buildList(restaurant.menus.drinks),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Top Foods',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buildList(restaurant.menus.foods),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildList(List<Drink> foodDrink) {
    return SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: foodDrink.map(
            (drink) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 100,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              secondaryColor.withOpacity(0.7),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            drink.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ));
  }
}
