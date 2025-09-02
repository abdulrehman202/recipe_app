// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseBackgroundMessagingHandler(RemoteMessage message) async
// {
//   // await NotificationService.
// }

// class NotificationService {

//   NotificationService._();

//   static final NotificationService instance = NotificationService._();
  
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
//   bool _isFlutterLocalNotificationsInitialized = false;

//   Future initialise() async {

//     FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessagingHandler);

//     await _requestPermision();
    
//     await _setupMessageHandlers();

//     final String? token = await _messaging.getToken();

//     await subscribeToTopic('sample'); 
//   }
  
//   Future<void> _requestPermision() async {}
  
//   Future<void> _setupMessageHandlers() async 
//   {
//     _localNotifications.initialize(InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher')
//     ),
//     onDidReceiveNotificationResponse: (details)
//     {
      
//     }
//     );    
//   }
  
//   Future<void> subscribeToTopic(String s) async {
//     await FirebaseMessaging.instance.subscribeToTopic(s);
//   }
// }