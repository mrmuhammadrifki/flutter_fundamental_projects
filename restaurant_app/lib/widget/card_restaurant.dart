import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
            arguments: restaurant.id
          );
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: restaurant.id,
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
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
      ),
    );
  }
}
