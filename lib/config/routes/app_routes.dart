import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';
import 'package:wellwave_frontend/config/routes/route_utils.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/screen/health_assessment_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/article_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/mission_screen.dart';
import 'package:wellwave_frontend/features/leaderboard/presentation/screen/leaderboard_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_history_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';
import 'package:wellwave_frontend/features/profile/presentation/screen/achievement_screen.dart';
import 'package:wellwave_frontend/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:wellwave_frontend/features/profile/presentation/screen/profile_screen.dart';
import 'package:wellwave_frontend/features/notification/presentation/screen/reminder_screen.dart';
import 'package:wellwave_frontend/features/profile/presentation/screen/set_weekly_goal_screen.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/screen/start_overview_screen.dart';

import '../../features/notification/presentation/screen/drink_plan_screen.dart';
import '../../features/notification/presentation/screen/test_noti.dart';

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
                  return _buildPageWithNavBar(
                      context, state, const HomeScreen());
                },
                routes: [
                  GoRoute(
                      path: AppPages.profilePage,
                      name: AppPages.profileName,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return const NoTransitionPage(child: ProfileScreen());
                      },
                      routes: [
                        GoRoute(
                          path: AppPages.editProfilePage,
                          name: AppPages.editProfileName,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) {
                            return const NoTransitionPage(
                                child: EditProfileScreen());
                          },
                        ),
                        GoRoute(
                          path: AppPages.leaderboardlPage,
                          name: AppPages.leaderboardlName,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) {
                            return const NoTransitionPage(
                                child: LeaderboardScreen());
                          },
                        ),
                        GoRoute(
                          path: AppPages.achievementPage,
                          name: AppPages.achievementName,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) {
                            return _buildPageWithNavBar(
                                context, state, const AchievementScreen());
                          },
                        ),
                        GoRoute(
                            path: AppPages.reminderPage,
                            name: AppPages.reminderName,
                            pageBuilder:
                                (BuildContext context, GoRouterState state) {
                              return _buildPageWithNavBar(
                                  context, state, const ReminderScreen());
                            },
                            routes: [
                              GoRoute(
                                path: AppPages.drinkPlanPage,
                                name: AppPages.drinkPlanName,
                                pageBuilder: (BuildContext context,
                                    GoRouterState state) {
                                  return _buildPageWithNavBar(
                                      context, state, const DrinkPlanScreen());
                                },
                              ),
                            ]),
                        GoRoute(
                          path: AppPages.setWeeklyGoalPage,
                          name: AppPages.setWeeklyGoalName,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) {
                            return _buildPageWithNavBar(
                                context, state, const SetWeeklyGoalScreen());
                          },
                        ),
                      ]),
                  GoRoute(
                    path: AppPages.testNotiPage,
                    name: AppPages.testNotiName,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return const NoTransitionPage(child: TestNotiScreen());
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
