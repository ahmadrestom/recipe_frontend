import 'UserManagement/User.dart';

class Review{
  final String userId;
  final String text;
  final int likes;
  final int dislikes;
  final DateTime timeUploaded;


  Review({
    required this.userId,
    required this.text,
    required this.likes,
    required this.dislikes,
    required this.timeUploaded
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'] as String,
      text: json['text'] as String,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
      timeUploaded: DateTime.parse(json['timeUploaded'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'text': text,
      'likes': likes,
      'dislikes': dislikes,
      'timeUploaded': timeUploaded

    };
  }
}