import '../user.dart';

class Review{
  final User user;
  final String text;
  final double rating;
  int likes;
  int dislikes;

  Review({
    required this.user,
    required this.text,
    required this.rating,
    this.likes = 0,
    this.dislikes = 0,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: User.fromJson(json['user']),
      text: json['text'] as String,
      rating: json['rating'] as double,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'text': text,
      'rating': rating,
      'likes': likes,
      'dislikes': dislikes
    };
  }
}