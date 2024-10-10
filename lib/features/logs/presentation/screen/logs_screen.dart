import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/logs/data/repositories/logs_repositories.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/daily_logs.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/history_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/weekly_logs.dart';
import '../logs_bloc/logs_bloc.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogsBloc>(context).add(LogsFetched(DateTime.now()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LogsBloc>(context).add(LogsFetched(DateTime.now()));
      BlocProvider.of<LogsBloc>(context).add(LogsFetchedGraph(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LogsBloc(LogsRequestRepository()), 
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HistoryButton(),
            ],
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              DailyLogs(),
              WeeklyLogs(),
            ],
          ),
        ),
      ),
    );
  }
}
