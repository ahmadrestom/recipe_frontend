import '../user.dart';

class Review{
  final User user;
  final String text;
  final double rating;

  Review({required this.user, required this.text, required this.rating});
}