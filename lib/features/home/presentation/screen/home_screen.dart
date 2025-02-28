import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/floating_button_with_shake.dart';
import 'package:wellwave_frontend/features/home/widget/progress_widget.dart';
import 'package:wellwave_frontend/features/home/widget/top_of_screen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> _requestPermissions() async {
//   if (await Permission.notification.isDenied) {
//     await Permission.notification.request();
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin
  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    // _initializeNotifications();
  }

  // void _initializeNotifications() async {
  //   const AndroidInitializationSettings androidSettings =
  //       AndroidInitializationSettings(
  //           '@mipmap/ic_launcher'); // Change icon path if needed

  //   const InitializationSettings settings =
  //       InitializationSettings(android: androidSettings);

  //   await flutterLocalNotificationsPlugin.initialize(
  //     settings,
  //     onDidReceiveNotificationResponse: (NotificationResponse response) {
  //       debugPrint('Notification clicked: ${response.payload}');
  //     },
  //   );
  // }

  // Show a simple notification
  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     channelDescription: 'Description of your channel',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //   const NotificationDetails platformDetails =
  //       NotificationDetails(android: androidDetails);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Reminder',
  //     'Time to go to bed!',
  //     platformDetails,
  //     payload: 'bedtime_notification',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          final notifications = state.notiData;

          return Stack(
            children: [
              Positioned(
                top: 48.0,
                left: -16.0,
                child: SvgPicture.asset(
                  AppImages.cloudImage,
                ),
              ),
              Positioned(
                top: 108.0,
                right: -24.0,
                child: SvgPicture.asset(
                  AppImages.cloudImage,
                ),
              ),
              const SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40.0, left: 24, right: 24, bottom: 24),
                      child: const TopOfScreen(
                          // notifications: notifications!,
                          ),
                    ),
                    ProgressWidget(),
                  ],
                ),
              ),
              const FloatingButtonWithShake(),
            ],
          );
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Initial State'));
        }
      }),
    );
  }
}
