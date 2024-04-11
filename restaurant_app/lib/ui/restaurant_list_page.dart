import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_response_model.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          if (restaurants.isEmpty) {
            return const Center(child: Text('Data tidak ditemukan.'));
          } else {
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurants[index]);
              },
            );
          }
        }
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: restaurant.id,
          child: Image.network(
            restaurant.pictureId,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (ctx, error, _) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
      ),
      title: Text(restaurant.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child:
                      Icon(Icons.location_on, color: secondaryColor, size: 16),
                ),
                const WidgetSpan(
                  child: SizedBox(width: 4),
                ),
                TextSpan(
                  text: restaurant.city,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(Icons.star, color: secondaryColor, size: 16),
                ),
                const WidgetSpan(
                  child: SizedBox(width: 4),
                ),
                TextSpan(
                  text: restaurant.rating.toString(),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
