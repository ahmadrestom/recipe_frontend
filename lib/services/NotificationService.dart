import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/Providers/NotificationProvider.dart';
import 'package:recipe_app/models/notification.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:http/http.dart' as http;

class NotificationService extends BaseAPI{

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<List<Notification>> getAllNotifications() async{
    try{
      final token = await _secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }
      final response = await http.get(
        Uri.parse(super.getAllNotificationsAPI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Notification> notifications = data.map((json) => Notification.fromJson(json)).toList();
        return notifications;
      }else{
        print("Error fetching notifications: ${response.body}");
        throw Exception("Error fetching notifications: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error getting notifications::$e");
    }

  }

  Future<void> deleteNotification(String notificationId) async{
    try{
      final token = await _secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }
      final response = await http.delete(
        Uri.parse("${super.deleteNotificationAPI}/$notificationId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        print("Notification removed successfully");
      }else{
        throw Exception("Error deleting notification: ${response.statusCode}");
      }

    }catch(e){
      throw Exception("Error deleting notification");
    }
  }

  Future<void> markAsRead(String notificationId) async{
    try{
      final token = await _secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }
      final response = await http.put(
        Uri.parse("${super.markAsReadAPI}/$notificationId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        print("Marked as read");
      }else{
        throw Exception("Error marking as read ${response.statusCode}:::${response.body}");
      }
    }catch(e){
      throw Exception("Error marking as read: $e");
    }
  }





}