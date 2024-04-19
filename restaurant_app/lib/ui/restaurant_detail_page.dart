// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Restaurant'),
      ),
      body: FutureBuilder(
        future: Provider.of<DetailProvider>(context, listen: false)
            .getDetailRestaurant(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          } else {
            return Consumer<DetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: secondaryColor),
                  );
                } else if (state.state == ResultState.hasData) {
                  var restaurant = state.detailResult.restaurant;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: restaurant.id,
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
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
                                  const Icon(Icons.location_on,
                                      color: secondaryColor),
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
                              _buildList(restaurant.menus.drinks,
                                  restaurant.pictureId),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Top Foods',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              _buildList(
                                  restaurant.menus.foods, restaurant.pictureId),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: reviewController,
                                      decoration: const InputDecoration(
                                        hintText: 'Tulis review...',
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                    ),
                                    onPressed: () async {
                                      final provider =
                                          Provider.of<DetailProvider>(
                                              context,
                                              listen: false);
                                      try {
                                        final String restaurantId = id;
                                        const String userName =
                                            'Muhammad Rifki';
                                        final String userReview =
                                            reviewController.text;
                                        await provider.addReview(
                                            restaurantId, userName, userReview);
                                        reviewController.clear();
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                              'Review berhasil ditambahkan',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                    color: secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Error'),
                                            content: Text('$e'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                    color: secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Kirim'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: restaurant.customerReviews.length,
                                itemBuilder: (context, index) {
                                  var review =
                                      restaurant.customerReviews[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          child: Text(review.name[0]),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              review.name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                              child: Text(
                                                review.date,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(review.review),
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildList(List<Category> menus, String pictureId) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: menus.map(
          (menu) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/$pictureId',
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
                          menu.name,
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
      ),
    );
  }
}
