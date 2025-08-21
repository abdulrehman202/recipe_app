import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  PushNotificationService();

  Future initialise() async {
    
    _fcm.requestPermission();

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    }

    String m = ''; 
    try {
      String? token = await _fcm.getToken( vapidKey: 'BKQRKvKur8F-o5fcmfBM_4brez4Syt4n1ODjeGeXpNqlnZtoqe54OrslMw7oQAAMdXu2GaBT75qZ5PBymTfWJb4' );

      m = 'FirebaseMessaging token: $token';
    } catch (e) {
      m = e.toString();
    }

    print('Output: $m');

    FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      // Error getting token.
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification again: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
    });
  }
}
