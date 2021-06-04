import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future initializeApp() async {
    /* Push Notifications */
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    /* Handlers */
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    /* Local Notifications */
  }

  static Future _onBackgroundHandler(RemoteMessage message) async {
    print('background Handler: ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('Message Handler: ${message.messageId}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('Message Open App(Handler): ${message.messageId}');
  }
}
