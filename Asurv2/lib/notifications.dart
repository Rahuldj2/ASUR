//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:Asur/main.dart';
//   class NotificationServices{
//
//
//
//    final AndroidInitializationSettings _androidInitializationSettings = AndroidInitializationSettings('@mipmap/splash');
//
//
//    void initializeNotifications() async{
//      InitializationSettings initializationSettings = InitializationSettings(
//        android: _androidInitializationSettings
//      );
//
//
//     bool? initialized =   await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//      print('initialized $initialized');
//   }
//
//
//
//    void sendNotifications(String title, String body) async{
//      print('sending');
//
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channelId', 'channelName',
//      importance: Importance.high,
//      priority: Priority.max);
//      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
//
//      print('sent');
//   }
//   }