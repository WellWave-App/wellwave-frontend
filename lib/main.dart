import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:wellwave_frontend/features/logs/presentation/bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/notification/data/repositories/notification_repositories.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';

import 'features/notification/presentation/bloc/noti_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        RepositoryProvider<NotificationSettingRepository>(
          create: (context) => NotificationSettingRepository(),
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
          BlocProvider<NotiBloc>(
            create: (context) =>
                NotiBloc(context.read<NotificationSettingRepository>()),
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
