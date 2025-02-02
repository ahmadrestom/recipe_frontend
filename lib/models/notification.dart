import 'UserManagement/User.dart';

class Notification{
  final String notificationId;
  final String title;
  final String message;
  bool isRead;
  final DateTime createdAt;
  //final UserDTO user;

  Notification({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    //required this.user
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: json['notificationId'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      isRead: json['read'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      //user: UserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'title': title,
      'message': message,
      'read': isRead,
      'createdAt': createdAt.toIso8601String(),
      //'user': user.toJson(),
    };
  }


}