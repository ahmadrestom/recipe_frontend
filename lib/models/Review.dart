class Review{
  final ReviewUserData user;
  final String text;
  final DateTime timeUploaded;


  Review({
    required this.user,
    required this.text,
    required this.timeUploaded
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: ReviewUserData.fromJson(json['user'] as Map<String, dynamic>),
      text: json['text'] as String,
      timeUploaded: DateTime.parse(json['timeUploaded'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'text': text,
      'timeUploaded': timeUploaded

    };
  }
}

class ReviewUserData {
  final String imageUrl;
  final String firstName;
  final String lastName;
  final String userId;

  ReviewUserData({
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.userId,
  });

  factory ReviewUserData.fromJson(Map<String, dynamic> json) {
    return ReviewUserData(
      imageUrl: json['imageUrl'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'userId': userId,
    };
  }
}
