import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screen/home_sceen.dart';
import '../constants/app_pages.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppPages.splashPath,
      name: AppPages.splashName,
      builder: (BuildContext context, GoRouterState state) {
        return Container(
          color: Colors.blue, // หน้าสีฟ้า
          child: Center(child: Text('Splash Screen')),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          name: AppPages.homeName,
          path: AppPages.homePage,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: AppPages.toDoListName,
              name: AppPages.toDoListPage,
              builder: (BuildContext context, GoRouterState state) {
                return Container(
                  color: Colors.red, // หน้าสีแดง
                  child: Center(child: Text('ToDo List Screen')),
                );
              },
            ),
            GoRoute(
              path: AppPages.missionName,
              name: AppPages.missionPage,
              builder: (BuildContext context, GoRouterState state) {
                return Container(
                  color: Colors.green, // หน้าสีเขียว
                  child: Center(child: Text('Mission Screen')),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppPages.friendName,
          name: AppPages.friendPage,
          builder: (BuildContext context, GoRouterState state) {
            return Container(
              color: Colors.yellow, // หน้าสีเหลือง
              child: Center(child: Text('Friend Screen')),
            );
          },
        ),
        GoRoute(
          path: AppPages.articleName,
          name: AppPages.articlePage,
          builder: (BuildContext context, GoRouterState state) {
            return Container(
              color: Colors.orange, // หน้าสีส้ม
              child: Center(child: Text('Article Screen')),
            );
          },
        ),
      ],
    ),
  ],
);
