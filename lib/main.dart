import 'package:flutter/material.dart';

import 'package:notificaciones_app/services/push_notifications_service.dart';

import 'package:notificaciones_app/screens/home_screen.dart';
import 'package:notificaciones_app/screens/message_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();
  final GlobalKey<ScaffoldMessengerState> scaffoldmessengerKey =
      new GlobalKey();

  @override
  void initState() {
    super.initState();
    PushNotificationsService.messagesStream.listen((producto) {
      // print('MyApp: $producto');

      final snackBar = SnackBar(content: Text(producto));
      scaffoldmessengerKey.currentState?.showSnackBar(snackBar);

      /* Cambiando De Pantalla */
      navigatorKey.currentState?.pushNamed('message', arguments: producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: scaffoldmessengerKey, // Snacks
      routes: {
        'home': (_) => HomeScreen(),
        'message': (_) => MessageScreen(),
      },
    );
  }
}


/* 
POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send HTTP/1.1

Content-Type: application/json
Authorization: Bearer ya29.ElqKBGN2Ri_Uz...HnS_uNreA

{
   "message":{
      "token":"token_1",
      "data":{},
      "notification":{
        "title":"FCM Message"
        "body":"This is an FCM notification message!",
      }
   }
} */