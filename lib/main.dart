import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/authentication/data/repositories/auth_repository.dart';
import 'package:wellwave_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StartRecommendBloc>(
            create: (context) => StartRecommendBloc(totalPages: 3),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider<LogsBloc>(
            create: (context) =>
                LogsBloc(context.read<LogsRequestRepository>()),
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
