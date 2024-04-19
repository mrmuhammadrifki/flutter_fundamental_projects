class ReviewResult {
  final bool error;
  final String message;
  final List<CustomerReviews> customerReviews;

  ReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });
  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReviews>.from(
            json["customerReviews"].map((x) => CustomerReviews.fromJson(x))),
      );
}

class CustomerReviews {
  final String name;
  final String review;
  final String date;

  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });
  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}
