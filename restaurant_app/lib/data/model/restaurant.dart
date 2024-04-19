
class ListRestaurantResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  ListRestaurantResult({
    required this.error,
    this.message = '',
    this.count = 0,
    required this.restaurants,
  });
  factory ListRestaurantResult.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResult(
        error: json['error'] ?? false,
        message: json['message'] ?? '',
        count: json['count'] ?? 0,
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );
}
