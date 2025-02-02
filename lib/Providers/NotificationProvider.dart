import 'package:flutter/foundation.dart';
import 'package:recipe_app/models/notification.dart';
import 'package:recipe_app/services/NotificationService.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<Notification>? _notifications;

  List<Notification>? get notifications => _notifications;

  Future<void> fetchNotifications()async{
    try{
      _notifications = [];
      final List<Notification> data = await _notificationService.getAllNotifications();
      _notifications = data;
    }catch(e){
      throw Exception("Error in provider: $e");
    }finally{
      notifyListeners();
    }
  }

  Future<void> deleteNotification(String notificationId) async{
    try{
      await _notificationService.deleteNotification(notificationId);
      _notifications?.removeWhere((notification) => notification.notificationId == notificationId);
    }catch(e){
      throw Exception("Error deleting provider");
    }finally{
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId) async{
    try{
      await _notificationService.markAsRead(notificationId);
    }catch(e){
      throw Exception("ERROR");
    }finally{
      notifyListeners();
    }
  }
}