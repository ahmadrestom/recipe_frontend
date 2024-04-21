import '../user.dart';

class Review{
  final User user;
  final String text;
  final double rating;

  Review({required this.user, required this.text, required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: User.fromJson(json['user']),
      text: json['text'] as String,
      rating: json['rating'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'text': text,
      'rating': rating,
    };
  }
}