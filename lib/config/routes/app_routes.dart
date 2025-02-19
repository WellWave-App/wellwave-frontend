import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/common/widget/custom_nav_bar.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/enums/navigation_enum.dart';
import 'package:wellwave_frontend/features/authentication/presentation/screen/authentication_screen.dart';
import 'package:wellwave_frontend/features/authentication/presentation/screen/page/forgot_password_sceen.dart';
import 'package:wellwave_frontend/features/authentication/presentation/screen/page/login_screen.dart';
import 'package:wellwave_frontend/features/authentication/presentation/screen/page/register_screen.dart';
import 'package:wellwave_frontend/features/authentication/presentation/widget/register_success.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/article_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/friend_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home/notification_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/mission_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_history_screen.dart';
import 'package:wellwave_frontend/features/logs/presentation/screen/logs_screen.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/splash_screen.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/screen/start_overview_screen.dart';

import '../../features/home/presentation/screen/home/health_reassessment.dart';

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
          path: AppPages.authenticationPage,
          name: AppPages.authenticationName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: AuthenticationScreen());
          },
        ),
        GoRoute(
          path: AppPages.registerPage,
          name: AppPages.registerName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: RegisterScreen());
          },
        ),
        GoRoute(
          path: AppPages.registerSuccessPage,
          name: AppPages.registerSuccessName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: RegisterSuccess());
          },
        ),
        GoRoute(
          path: AppPages.loginPage,
          name: AppPages.loginName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: LoginScreen());
          },
        ),
        GoRoute(
          path: AppPages.forgotPasswordPage,
          name: AppPages.forgetPasswordName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: ForgotPasswordScreen());
          },
        ),
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
              return _buildPageWithNavBar(context, state, const LogsScreen());
            },
            routes: [
              GoRoute(
                path: AppPages.logHistoryPage,
                name: AppPages.logHistoryName,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return _buildPageWithNavBar(
                      context, state, const LogsHistoryScreen());
                },
              ),
            ]),
        GoRoute(
          path: AppPages.missionPage,
          name: AppPages.missionName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _buildPageWithNavBar(context, state, const MissionScreen());
          },
        ),
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
        GoRoute(
          path: AppPages.reassessmentPage,
          name: AppPages.reassessmentName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              child: ReAssessmentScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            );
          },
        ),
        GoRoute(
          path: AppPages.notificationPage,
          name: AppPages.notificationName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: NotificationScreen());
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

// final GoRouter goRouter = GoRouter(
//   initialLocation: AppPages.splashPath,
//   routes: [
//     GoRoute(
//       path: AppPages.splashPath,
//       name: AppPages.splashName,
//       builder: (BuildContext context, GoRouterState state) {
//         return const SplashScreen();
//       },
//       routes: [
//         ShellRoute(
//           builder: (context, state, child) {
//             final bool isTargetPage = isTargetPageCheck(state.uri.toString());
//             return Scaffold(
//               body: child,
//               bottomNavigationBar: isTargetPage
//                   ? CustomNavigationBar(
//                       selectedIndex: _getSelectedIndex(state),
//                       onItemTapped: (index) {
//                         context.goNamed(NavigationPage.values[index].name);
//                       },
//                     )
//                   : null,
//             );
//           },
//           routes: [
//             GoRoute(
//               path: AppPages.startPage,
//               name: AppPages.startName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return NoTransitionPage(child: StartOverviewScreen());
//               },
//             ),
//             GoRoute(
//                 path: AppPages.homePage,
//                 name: AppPages.homeName,
//                 pageBuilder: (BuildContext context, GoRouterState state) {
//                   return _buildPageWithNavBar(
//                       context, state, const HomeScreen());
//                 },
//                 routes: [
//                   GoRoute(
//                       path: AppPages.profilePage,
//                       name: AppPages.profileName,
//                       pageBuilder: (BuildContext context, GoRouterState state) {
//                         return const NoTransitionPage(child: ProfileScreen());
//                       },
//                       routes: [
//                         GoRoute(
//                           path: AppPages.editProfilePage,
//                           name: AppPages.editProfileName,
//                           pageBuilder:
//                               (BuildContext context, GoRouterState state) {
//                             return const NoTransitionPage(
//                                 child: EditProfileScreen());
//                           },
//                         ),
//                         GoRoute(
//                           path: AppPages.leaderboardlPage,
//                           name: AppPages.leaderboardlName,
//                           pageBuilder:
//                               (BuildContext context, GoRouterState state) {
//                             return const NoTransitionPage(
//                                 child: LeaderboardScreen());
//                           },
//                         ),
//                         GoRoute(
//                           path: AppPages.achievementPage,
//                           name: AppPages.achievementName,
//                           pageBuilder:
//                               (BuildContext context, GoRouterState state) {
//                             return _buildPageWithNavBar(
//                                 context, state, const AchievementScreen());
//                           },
//                         ),
//                         GoRoute(
//                             path: AppPages.reminderPage,
//                             name: AppPages.reminderName,
//                             pageBuilder:
//                                 (BuildContext context, GoRouterState state) {
//                               return _buildPageWithNavBar(
//                                   context, state, const ReminderScreen());
//                             },
//                             routes: [
//                               GoRoute(
//                                 path: AppPages.drinkPlanPage,
//                                 name: AppPages.drinkPlanName,
//                                 pageBuilder: (BuildContext context,
//                                     GoRouterState state) {
//                                   return _buildPageWithNavBar(
//                                       context, state, const DrinkPlanScreen());
//                                 },
//                               ),
//                             ]),
//                         GoRoute(
//                           path: AppPages.setWeeklyGoalPage,
//                           name: AppPages.setWeeklyGoalName,
//                           pageBuilder:
//                               (BuildContext context, GoRouterState state) {
//                             return _buildPageWithNavBar(
//                                 context, state, const SetWeeklyGoalScreen());
//                           },
//                         ),
//                       ]),
//                   GoRoute(
//                     path: AppPages.testNotiPage,
//                     name: AppPages.testNotiName,
//                     pageBuilder: (BuildContext context, GoRouterState state) {
//                       return const NoTransitionPage(child: TestNotiScreen());
//                     },
//                   ),
//                 ]),
//             GoRoute(
//                 path: AppPages.logPage,
//                 name: AppPages.logName,
//                 pageBuilder: (BuildContext context, GoRouterState state) {
//                   return const NoTransitionPage(child: LogsScreen());
//                 },
//                 routes: [
//                   GoRoute(
//                     path: AppPages.logHistoryPage,
//                     name: AppPages.logHistoryName,
//                     pageBuilder: (BuildContext context, GoRouterState state) {
//                       return const NoTransitionPage(child: LogsHistoryScreen());
//                     },
//                   ),
//                 ]),
//             GoRoute(
//               path: AppPages.missionPage,
//               name: AppPages.missionName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return const NoTransitionPage(child: MissionScreen());
//               },
//             ),
//             GoRoute(
//               path: AppPages.friendPage,
//               name: AppPages.friendName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return const NoTransitionPage(child: FriendScreen());
//               },
//             ),
//             GoRoute(
//               path: AppPages.articlePage,
//               name: AppPages.articleName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return const NoTransitionPage(child: ArticleScreen());
//               },
//             ),
//             GoRoute(
//               path: AppPages.assessmentPage,
//               name: AppPages.assessmentName,
//               builder: (BuildContext context, GoRouterState state) {
//                 return const AssessmentScreen();
//               },
//             ),
//             GoRoute(
//               path: AppPages.reassessmentPage,
//               name: AppPages.reassessmentName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return CustomTransitionPage(
//                   child: ReAssessmentScreen(),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     return child;
//                   },
//                 );
//               },
//             ),
//             // GoRoute(
//             //   path: AppPages.findFriendPage,
//             //   name: AppPages.findFriendName,
//             //   pageBuilder: (BuildContext context, GoRouterState state) {
//             //     return NoTransitionPage(child: FindFriendScreen());
//             //   },
//             // ),
//             // GoRoute(
//             //   path: AppPages.profileFriendPage,
//             //   name: AppPages.profileFriendName,
//             //   pageBuilder: (BuildContext context, GoRouterState state) {
//             //     return NoTransitionPage(child: ProfileFriends());
//             //   },
//             // ),
//             GoRoute(
//               path: AppPages.notificationPage,
//               name: AppPages.notificationName,
//               pageBuilder: (BuildContext context, GoRouterState state) {
//                 return NoTransitionPage(child: NotificationScreen());
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
