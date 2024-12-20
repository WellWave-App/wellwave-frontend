import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LogsRequestRepository>(
          create: (context) => LogsRequestRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StartOverviewBloc>(
            create: (context) => StartOverviewBloc(),
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