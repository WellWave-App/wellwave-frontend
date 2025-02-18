import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/home/data/repositories/home_repository.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HealthAssessmentRepository>(
          create: (context) => HealthAssessmentRepository(),
        ),
        RepositoryProvider<ProfileRepositories>(
          create: (context) => ProfileRepositories(),
        ),
        RepositoryProvider<LoginStreakRepository>(
          create: (context) => LoginStreakRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              profileRepository: ProfileRepositories(),
              currentDate: DateTime.now(),
              healthAssessmentRepository: HealthAssessmentRepository(),
              loginStreakRepository: LoginStreakRepository(),
              notificationsRepository: NotificationsRepository(),
            )..add(FetchHomeEvent()),
          ),
          // BlocProvider<FriendBloc>(
          //   create: (context) => FriendBloc(
          //       profileRepositories: context.read<ProfileRepositories>()),
          //   lazy: false,
          // ),
          BlocProvider<HealthAssessmentPageBloc>(
            create: (context) => HealthAssessmentPageBloc(
                context.read<HealthAssessmentRepository>()),
          ),
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
