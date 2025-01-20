import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wellwave_frontend/api/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().initNotifications();

  runApp(const TestNotiScreen());
}

// Future<void> _backgroundHandler(RemoteMessage message) async {
//   // Handle background message
//   debugPrint('Background message received: ${message.messageId}');
// }

class TestNotiScreen extends StatelessWidget {
  const TestNotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Firebase Notifications')),
        body: const Center(
          child: Text('Waiting for messages'),
        ));
  }
}

// class NotificationWidget extends StatefulWidget {
//   const NotificationWidget({super.key});

//   @override
//   _NotificationWidgetState createState() => _NotificationWidgetState();
// }

// class _NotificationWidgetState extends State<NotificationWidget> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();

//     // Request permissions for iOS
//     _firebaseMessaging.requestPermission();

//     // Retrieve the FCM token
//     _getToken();

//     // Listen for token refresh
//     _firebaseMessaging.onTokenRefresh.listen((String token) {
//       debugPrint('Token refreshed: $token');
//       _sendRegistrationToServer(token);
//     });

//     // Listen for foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Message received: ${message.messageId}');
//       if (message.notification != null) {
//         debugPrint('Notification title: ${message.notification!.title}');
//         debugPrint('Notification body: ${message.notification!.body}');
//       }
//     });

//     // Handle when the app is opened from a notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('Notification clicked: ${message.messageId}');
//     });
//   }

//   Future<void> _getToken() async {
//     try {
//       String? token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         debugPrint('FCM Token: $token');
//         _sendRegistrationToServer(token);

//         // Display the token using a Flutter Toast or Snackbar
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('FCM Token: $token')),
//         );
//       } else {
//         debugPrint('Failed to retrieve FCM token.');
//       }
//     } catch (e) {
//       debugPrint('Error retrieving FCM token: $e');
//     }
//   }

//   void _sendRegistrationToServer(String token) {
//     // Send the token to your server if needed
//     debugPrint('Sending token to server: $token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Waiting for messages'),
//     );
//   }
// }
