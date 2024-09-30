import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_waistline.dart';
import 'package:wellwave_frontend/features/logs/data/models/logs_request_model_weight.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';

class LineChartSample2 extends StatefulWidget {
  final String logType; // logType: "WEIGHT_LOG" or "WAIST_LINE_LOG"

  const LineChartSample2({super.key, required this.logType});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xFFADB7F9),
    const Color.fromARGB(0, 177, 185, 248),
  ];

  List<dynamic> weeklyLogs = []; // Use dynamic to hold both types of logs

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    context.read<LogsBloc>().add(LogsFetchedGraph(today)); // Pass logType to fetch method
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        if (state is LogsLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LogsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is LogsLoadGraphSuccess) {
          // Determine which logs to use based on the logType
          if (widget.logType == "WEIGHT_LOG") {
            weeklyLogs = state.logsWeightlist; // Fetch weight logs
          } else if (widget.logType == "WAIST_LINE_LOG") {
            weeklyLogs = state.logsWaistLinelist; // Fetch waistline logs
          }

          // Ensure weeklyLogs is not empty before accessing its values
          if (weeklyLogs.isEmpty) {
            return const Center(child: Text('No logs available'));
          }

          // Calculate minY and maxY based on the fetched log values
          double minY = weeklyLogs
              .where((log) => log != null)
              .map((log) => log!.value)
              .reduce((a, b) => a < b ? a : b)
              .toDouble();
          double maxY = weeklyLogs
              .where((log) => log != null)
              .map((log) => log!.value)
              .reduce((a, b) => a > b ? a : b)
              .toDouble();

          // Adjust minY and maxY with some padding for better display
          minY = minY - (minY * 0.1); // Add 10% padding to the min
          maxY = maxY + (maxY * 0.1); // Add 10% padding to the max

          return Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  child: LineChart(
                    mainData(minY, maxY),
                  ),
                ),
              ),
            ],
          );
        }

        return Container(); // Return an empty container if no relevant state
      },
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );

    // Check if we have enough data for the requested index
    if (value.toInt() < weeklyLogs.length) {
      final log = weeklyLogs[value.toInt()];
      if (log != null) {
        final date = DateTime.parse(
            log.date.toIso8601String()); // Parse the date from the log
        final formattedDate =
            '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'; // Format to MM-DD
        return SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(formattedDate, style: style),
        );
      }
    }
    return const Text('-', style: style);
  }

  LineChartData mainData(double minY, double maxY) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xFFB1B1B1),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: Color(0xFFB1B1B1), width: 0.5),
          right: BorderSide(color: Color(0xFFB1B1B1), width: 0.5),
        ),
      ),
      minX: 0,
      maxX: (weeklyLogs.length - 1).toDouble(), // Adjust based on the number of logs
      minY: minY,
      maxY: maxY, // Use dynamic minY and maxY
      lineBarsData: [
        LineChartBarData(
          spots: weeklyLogs.asMap().entries.map((entry) {
            final index = entry.key;
            final log = entry.value;
            if (log != null) {
              return FlSpot(index.toDouble(), log.value.toDouble());
            }
            return FlSpot(index.toDouble(), 0); // Default value if log is null
          }).toList(),
          isCurved: true,
          color: const Color(0xFF001DFF),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
