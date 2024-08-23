import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/routes/route_utils.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/article_screeen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/assessment_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/mission_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/note_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppPages.splashPath,
  routes: [
    GoRoute(
      path: AppPages.splashPath,
      name: AppPages.splashName,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            final bool isTargetPage = isTargetPageCheck(state.uri.toString());
            return Scaffold(
              body: child,
              bottomNavigationBar: isTargetPage
                  ? CustomNavigationBar(
                      selectedIndex: _getSelectedIndex(state),
                      onItemTapped: (index) {
                        context.goNamed(NavigationPage.values[index].name);
                      },
                    )
                  : null,
            );
          },
          routes: [
            GoRoute(
              path: AppPages.homePage,
              name: AppPages.homeName,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: AppPages.logPage,
              name: AppPages.logName,
              builder: (BuildContext context, GoRouterState state) {
                return const NoteScreen();
              },
            ),
            GoRoute(
              path: AppPages.missionPage,
              name: AppPages.missionName,
              builder: (BuildContext context, GoRouterState state) {
                return const MissionScreen();
              },
            ),
            GoRoute(
              path: AppPages.friendPage,
              name: AppPages.friendName,
              builder: (BuildContext context, GoRouterState state) {
                return const FriendScreen();
              },
            ),
            GoRoute(
              path: AppPages.articlePage,
              name: AppPages.articleName,
              builder: (BuildContext context, GoRouterState state) {
                return const ArticleScreen();
              },
            ),
            GoRoute(
              path: AppPages.assessmentPage,
              name: AppPages.assessmentName,
              builder: (BuildContext context, GoRouterState state) {
                return AssessmentScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
int _getSelectedIndex(GoRouterState state) {
  final path = state.fullPath;
  if (path!.contains(AppPages.homePage)) return 0;
  if (path.contains(AppPages.logPage)) return 1;
  if (path.contains(AppPages.missionPage)) return 2;
  if (path.contains(AppPages.friendPage)) return 3;
  if (path.contains(AppPages.articlePage)) return 4;
  if (path.contains(AppPages.assessmentPage)) return 5;
  return 0; // Default to home page if path is not matched
}
// final GoRouter goRoute = GoRouter(
//   routes: <RouteBase>[
// path: AppPages.splashPath,
// name: AppPages.splashName,
//       builder: (BuildContext context, GoRouterState state) {
//         return const SplashScreen();
//       },
// ]>) {
//   return GoRouter(
//     routes: [
//       GoRoute(
//         path: AppPages.splashPath,
//         builder: (context, state) => CustomNavigationBar(
//           router: GoRouter.of(context), // ส่ง GoRouter instance ที่ถูกต้อง
//         ),
//         routes: [
//           GoRoute(
//             path: AppPages.homePage,
//             builder: (context, state) => const HomeScreen(),
//           ),
//           GoRoute(
//             path: AppPages.logPage,
//             builder: (context, state) => const NoteScreen(),
//           ),
//           GoRoute(
//             path: AppPages.missionPage,
//             builder: (context, state) => const MissionScreen(),
//           ),
//           GoRoute(
//             path: AppPages.friendPage,
//             builder: (context, state) => const FriendScreen(),
//           ),
//           GoRoute(
//             path: AppPages.articlePage,
//             builder: (context, state) => const ArticleScreen(),
//           ),
//         ],
//       ),
//     ],
//   );
// }
