import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';
import 'package:wellwave_frontend/config/routes/route_utils.dart';
import 'package:wellwave_frontend/features/exchange/presentation/screen/exchange_screen.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/screen/health_assessment_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/article_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/mission_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_history_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/screen/start_overview_screen.dart';

int _getSelectedIndex(GoRouterState state) {
  final path = state.fullPath;
  if (path!.contains(AppPages.homePage)) return 0;
  if (path.contains(AppPages.logPage)) return 1;
  if (path.contains(AppPages.missionPage)) return 2;
  if (path.contains(AppPages.friendPage)) return 3;
  if (path.contains(AppPages.articlePage)) return 4;

  return 0; // Default to home page if path is not matched
}

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
              path: AppPages.startPage,
              name: AppPages.startName,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: StartOverviewScreen());
              },
            ),
            GoRoute(
                path: AppPages.homePage,
                name: AppPages.homeName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: HomeScreen());
                },
                routes: [
                  GoRoute(
                    path: AppPages.exchangePage,
                    name: AppPages.exchangeName,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return const NoTransitionPage(child: ExchangeScreen());
                    },
                  ),
                ]),
            GoRoute(
                path: AppPages.logPage,
                name: AppPages.logName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: LogsScreen());
                },
                routes: [
                  GoRoute(
                    path: AppPages.logHistoryPage,
                    name: AppPages.logHistoryName,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return const NoTransitionPage(child: LogsHistoryScreen());
                    },
                  ),
                ]),
            GoRoute(
              path: AppPages.missionPage,
              name: AppPages.missionName,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: MissionScreen());
              },
            ),
            GoRoute(
              path: AppPages.friendPage,
              name: AppPages.friendName,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: FriendScreen());
              },
            ),
            GoRoute(
              path: AppPages.articlePage,
              name: AppPages.articleName,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: ArticleScreen());
              },
            ),
            GoRoute(
              path: AppPages.assessmentPage,
              name: AppPages.assessmentName,
              builder: (BuildContext context, GoRouterState state) {
                return const AssessmentScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
