// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/article/data/models/article_bookmark.dart';
import 'package:wellwave_frontend/features/article/data/repositories/article_repository.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
import 'package:wellwave_frontend/features/article/presentation/screen/article_screen.dart';
import 'package:wellwave_frontend/features/leaderboard/data/repositories/leaderboard_repositories.dart';
import 'package:wellwave_frontend/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:wellwave_frontend/features/logs/presentation/bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/notification/data/repositories/notification_repositories.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/archeivement_repositories.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/archeivement_bloc/archeivement_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';

import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/notification/presentation/bloc/noti_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/home/data/repositories/home_repository.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LogsRequestRepository>(
          create: (context) => LogsRequestRepository(),
        ),
        RepositoryProvider<NotificationSettingRepository>(
          create: (context) => NotificationSettingRepository(),
        ),
        RepositoryProvider<ArcheivementRepositories>(
          create: (context) => ArcheivementRepositories(),
        ),
        RepositoryProvider<HealthAssessmentRepository>(
          create: (context) => HealthAssessmentRepository(),
        ),
        RepositoryProvider<ProfileRepositories>(
          create: (context) => ProfileRepositories(),
        ),
        RepositoryProvider<LoginStreakRepository>(
          create: (context) => LoginStreakRepository(),
        ),
        RepositoryProvider<ArticleRepository>(
          create: (context) => ArticleRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StartRecommendBloc>(
            create: (context) => StartRecommendBloc(totalPages: 3),
          ),
          BlocProvider<LogsBloc>(
            create: (context) =>
                LogsBloc(context.read<LogsRequestRepository>()),
            lazy: false,
          ),
          BlocProvider<ProfileBloc>(
            create: (context) =>
                ProfileBloc(profileRepositories: ProfileRepositories()),
            lazy: false,
          ),
          BlocProvider<LeaderBoardBloc>(
            create: (context) => LeaderBoardBloc(
                leaderBoardRepositories: LeaderboardRepositories()),
            lazy: false,
          ),
          BlocProvider<NotiBloc>(
            create: (context) =>
                NotiBloc(context.read<NotificationSettingRepository>()),
            lazy: false,
          ),
          BlocProvider<ArcheivementBloc>(
            create: (context) => ArcheivementBloc(
                archeivementRepositories: ArcheivementRepositories()),
            lazy: false,
          ),
          BlocProvider(
              create: (context) => ArticleBloc(
                    ArticleRepository(),
                    // Pass a default instance of BookmarkModel
                  )),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              profileRepository: ProfileRepositories(),
              currentDate: DateTime.now(),
              healthAssessmentRepository: HealthAssessmentRepository(),
              loginStreakRepository: LoginStreakRepository(),
              notificationsRepository: NotificationsRepository(),
            )..add(FetchHomeEvent()),
          ),

          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),

          // BlocProvider<FriendBloc>(
          //   create: (context) => FriendBloc(
          //       profileRepositories: context.read<ProfileRepositories>()),
          //   lazy: false,
          // ),
        ],
        child: MaterialApp.router(
          routerConfig: goRouter,
          title: 'WellWave Application',
          debugShowCheckedModeBanner: false,
          theme: appTheme(context),
        ),
      ),
    );
  }
}
