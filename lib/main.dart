import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/health_assessment/data/repositories/health_assessment_repository.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/home/data/repositories/home_repository.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';

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
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<HealthAssessmentBloc>(
                create: (context) =>
                    HealthAssessmentBloc(HealthAssessmentRepository()),
              ),
              BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(
                  currentDate: DateTime.now(),
                  healthAssessmentRepository: HealthAssessmentRepository(),
                  loginStreakRepository: LoginStreakRepository(),
                ),
              ),
            ],
            child: MaterialApp.router(
              routerConfig: goRouter,
              title: 'WellWave Application',
              debugShowCheckedModeBanner: false,
              theme: appTheme(context),
            )));
  }
}
