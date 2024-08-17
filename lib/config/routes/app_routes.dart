import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppPages.splashPath,
      builder: (context, state) => const BottomNavigationBarExample(),
      routes: [
        GoRoute(
          path: AppPages.homePage,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
  ],
);
