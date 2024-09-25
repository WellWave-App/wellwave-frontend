import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/routes/app_routes.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/mission/presentation/bloc/mission_bloc.dart';
import 'package:wellwave_frontend/features/start_overview/presentation/bloc/start_overview_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartOverviewBloc>(
          create: (context) => StartOverviewBloc(),
        ),
        BlocProvider<MissionBloc>(
          create: (context) => MissionBloc(),
        ),
        // BlocProvider is required to continue using bloc.
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        title: 'WellWave Application',
        debugShowCheckedModeBanner: false,
        theme: appTheme(context),
      ),
    );
  }
}
