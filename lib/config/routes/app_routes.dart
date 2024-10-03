import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/article_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:wellwave_frontend/features/mission/presentation/screen/mission_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/note_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';
import 'package:wellwave_frontend/features/mission/presentation/screen/page/daily_task_page.dart';
import 'package:wellwave_frontend/features/mission/presentation/screen/page/habit_challenge_page.dart';
import 'package:wellwave_frontend/features/mission/presentation/screen/page/quest_page.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/screen/start_overview_screen.dart';

import '../../features/mission/presentation/screen/page/quest_detail_page.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppPages.splashPath,
  routes: [
    GoRoute(
      path: AppPages.splashPath,
      name: AppPages.splashName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SplashScreen());
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
            return _buildPageWithNavBar(context, state, const HomeScreen());
          },
        ),
        GoRoute(
          path: AppPages.logPage,
          name: AppPages.logName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPageWithNavBar(context, state, const NoteScreen());
          },
        ),
        GoRoute(
            path: AppPages.missionPage,
            name: AppPages.missionName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _buildPageWithNavBar(
                  context, state, const MissionScreen());
            },
            routes: [
              GoRoute(
                path: AppPages.dailyTaskPage,
                name: AppPages.dailyTaskName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(child: DailyTaskPage());
                },
              ),
              GoRoute(
                path: AppPages.habitChallengePage,
                name: AppPages.habitChallengeName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(child: HabitChallengePage());
                },
              ),
              GoRoute(
                  path: AppPages.questPage,
                  name: AppPages.questName,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(child: QuestPage());
                  },
                  routes: [
                    GoRoute(
                      path: AppPages.questDetailPage,
                      name: AppPages.questDetailName,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return const NoTransitionPage(child: QuestDetailPage());
                      },
                    )
                  ]),
            ]),
        GoRoute(
          path: AppPages.friendPage,
          name: AppPages.friendName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPageWithNavBar(context, state, const FriendScreen());
          },
        ),
        GoRoute(
          path: AppPages.articlePage,
          name: AppPages.articleName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPageWithNavBar(context, state, const ArticleScreen());
          },
        ),
      ],
    ),
  ],
);

Page _buildPageWithNavBar(
    BuildContext context, GoRouterState state, Widget child) {
  return NoTransitionPage(
    child: Scaffold(
      body: child,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _getSelectedIndex(state),
        onItemTapped: (index) {
          context.goNamed(NavigationPage.values[index].name);
        },
      ),
    ),
  );
}

int _getSelectedIndex(GoRouterState state) {
  final path = state.fullPath;
  if (path!.contains(AppPages.homePage)) return 0;
  if (path.contains(AppPages.logPage)) return 1;
  if (path.contains(AppPages.missionPage)) return 2;
  if (path.contains(AppPages.friendPage)) return 3;
  if (path.contains(AppPages.articlePage)) return 4;
  return 0;
}
