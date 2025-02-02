import 'dart:async';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/notification.dart' as n;
import '../Providers/NotificationProvider.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();


}

class _NotificationsState extends State<Notifications> {
  Timer? _timer;
  List<n.Notification>? allNotifications;
  List<n.Notification>? readNotifications;
  List<n.Notification>? unreadNotifications;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    //_startAutoRefresh();
  }

  void _fetchNotifications(){
     Future.microtask(() async{
      final provider = Provider.of<NotificationProvider>(context, listen: false);
      await provider.fetchNotifications();
      setState(() {
        allNotifications = provider.notifications;
        readNotifications = provider.notifications?.where((notification) => notification.isRead).toList();
        unreadNotifications = provider.notifications?.where((notification) => !notification.isRead).toList();
      });

    });
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchNotifications(); // Fetch new notifications every 10 seconds
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    unreadNotifications = [];
    readNotifications = [];
    allNotifications = [];
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(allNotifications == null){
      return const Center(child: CircularProgressIndicator(),);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body:Container(
          margin: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight *0.04, screenWidth*0.05, 0),
          child: Column(
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: screenWidth*0.001,),
                Text(
                  "Notifications",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.055,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(width: screenWidth*0.001,),
              ],
            ),
            //SizedBox(height: screenHeight*0.01,),
            TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.001),
              splashFactory: NoSplash.splashFactory,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(13), // Rounded corners
                color: const Color.fromRGBO(18, 149, 117, 1),
              ),
              indicatorWeight: 0,
              dividerHeight: 0,
              padding: EdgeInsets.symmetric(vertical: screenHeight *0.03, horizontal: screenWidth*0.05),
              labelColor: Colors.white, // Text color for active tab
              unselectedLabelColor: const Color.fromRGBO(18, 149, 117, 1),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            indicatorAnimation: TabIndicatorAnimation.elastic,

              tabs: [
                Tab(
                  height: screenHeight*0.04,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Text("Unread"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Text("Read"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: const Text("All"),
                  ),
                ),
              ],
            ),
              Expanded(
                child: TabBarView(
                  children: [
                    NotificationList(notifications: unreadNotifications!),
                    NotificationList(notifications: readNotifications!),
                    NotificationList(notifications: allNotifications!),
                  ],
                ),
              ),
          ]
                ),
        ),

      ),
    );
  }
}

class NotificationList extends StatefulWidget {
  final List<n.Notification> notifications;
  const NotificationList({super.key, required this.notifications});

  @override
  State<NotificationList> createState() => _NotificationList();
}

class _NotificationList extends State<NotificationList> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.notifications.length,
      itemBuilder: (context, index) {
        final notification = widget.notifications[index];

        return Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
          child: Dismissible(
            key: Key(notification.notificationId.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(210,11,33,1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            onDismissed: (direction) async {
              final notificationProvider =
              Provider.of<NotificationProvider>(context, listen: false);
              await notificationProvider
                  .deleteNotification(notification.notificationId);

              setState(() {
                widget.notifications.removeWhere(
                        (n) => n.notificationId == notification.notificationId);
              });

              CherryToast.success(
                description: const Text(
                  "Notification deleted successfully",
                  style: TextStyle(color: Color.fromRGBO(18, 149, 117, 1)),
                ),
                animationType: AnimationType.fromRight,
                animationDuration: const Duration(milliseconds: 700),
                toastPosition: Position.bottom,
                autoDismiss: true,
              ).show(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final notificationProvider =
                          Provider.of<NotificationProvider>(context,
                              listen: false);
                          await notificationProvider
                              .deleteNotification(notification.notificationId);
                          setState(() {
                            widget.notifications.removeWhere((n) =>
                            n.notificationId == notification.notificationId);
                          });

                          CherryToast.success(
                              description: const Text(
                                  "Notification deleted successfully",
                                  style: TextStyle(
                                    color: Color.fromRGBO(18, 149, 117, 1),
                                  )),
                              animationType: AnimationType.fromRight,
                              animationDuration:
                              const Duration(milliseconds: 700),
                              toastPosition: Position.bottom,
                              autoDismiss: true)
                              .show(context);
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          color: Color.fromRGBO(18, 149, 117, 1),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.message,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.createdAt.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          final provider = Provider.of<NotificationProvider>(context,listen: false);
                          await provider.markAsRead(notification.notificationId);
                          setState(() {
                            notification.isRead = true;
                          });
                        },
                        child: Icon(
                          notification.isRead==true?
                              Icons.notifications_none:Icons.notifications,
                            color: Colors.orange
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



/*
* Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
            final notifications = notificationProvider.notifications;

            if (notifications == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (notifications.isEmpty) {
              return const Center(child: Text("No notifications yet."));
            }

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.message),
                );
              },
            );
          },
        ),
* */
