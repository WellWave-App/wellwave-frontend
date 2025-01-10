import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';

class LineChartSample2 extends StatelessWidget {
  final String logType;
  final List<dynamic> logs;
  final String? selectedPeriod;

  const LineChartSample2(
      {super.key,
      required this.logType,
      required this.logs,
      this.selectedPeriod});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        if (state is LogsLoadGraphInProgress) {
          return Container();
        } else if (state is LogsError) {
          return Center(
              child: Text('${AppStrings.errorShow}: ${state.message}'));
        } else if (state is LogsLoadGraphSuccess) {
          if (logs.isEmpty) {
            return const Center(child: Text(AppStrings.noLogsAvailableText));
          }

          double minY = logs
              .where((log) => log != null)
              .map((log) => log!.value)
              .reduce((a, b) => a < b ? a : b)
              .toDouble();
          double maxY = logs
              .where((log) => log != null)
              .map((log) => log!.value)
              .reduce((a, b) => a > b ? a : b)
              .toDouble();

          minY = minY - (minY * 0.1);
          maxY = maxY + (maxY * 0.1);

          return Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  child: LineChart(
                    mainData(logs, minY, maxY),
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  LineChartData mainData(List<dynamic> logs, double minY, double maxY) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 1,
        getDrawingVerticalLine: (value) =>
            const FlLine(color: Color(0xFFB1B1B1), strokeWidth: 0.5),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(logs, value, meta),
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
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
      maxX: (logs.length - 1).toDouble(),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: logs.asMap().entries.map((entry) {
            final index = entry.key;
            final log = entry.value;
            return FlSpot(
                index.toDouble(), log != null ? log.value.toDouble() : 0);
          }).toList(),
          isCurved: false,
          color: const Color(0xFF001DFF),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              colors: [Color(0xFFADB7F9), Color.fromARGB(0, 177, 185, 248)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(List<dynamic> logs, double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    if (value.toInt() >= logs.length) {
      return const Text('/', style: style);
    }

    final log = logs[value.toInt()];
    final date = DateTime.parse(log.date.toIso8601String());

    // For 14 days view - show every other day

    if (selectedPeriod == '14 วัน') {
      if (value.toInt() % 2 == 0) {
        return SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}',
              style: style),
        );
      }
      return const Text('', style: style);
    }

    //3เดือน
    if (selectedPeriod == '3 เดือน') {
      final thaiMonths = [
        'มกราคม',
        'กุมภาพันธ์',
        'มีนาคม',
        'เมษายน',
        'พฤษภาคม',
        'มิถุนายน',
        'กรกฎาคม',
        'สิงหาคม',
        'กันยายน',
        'ตุลาคม',
        'พฤศจิกายน',
        'ธันวาคม'
      ];

      String month = thaiMonths[date.month - 1];
      if (value.toInt() % 4 == 0) {
        return SideTitleWidget(
          axisSide: AxisSide.right,
          space: 36.0,
          child: Text(month, style: TextStyle(fontSize: 14)),
        );
      }
      return const Text('', style: style);
    }

    // For 1 month
    // if (selectedPeriod == '1 เดือน') {
    //   List<int> monthNumbers = [];
    //   debugPrint('value: ${value.toInt()}');
    //   debugPrint('log: $log');
    //   debugPrint('monthNumbers: ${monthNumbers.toString()}');

    //   // Add the month only if it's not already added
    //   if (monthNumbers.length < 4) {
    //     monthNumbers.add(date.month);
    //   }

    //   // Determine the correct week numbers based on month values
    //   List<int> weekNumbers = [];
    //   if (monthNumbers.length == 4) {
    //     if (monthNumbers[0] == monthNumbers[3]) {
    //       weekNumbers = [7, 14, 21, 28];
    //     } else if (monthNumbers[0] != monthNumbers[3] &&
    //         monthNumbers[0] == monthNumbers[2]) {
    //       weekNumbers = [14, 21, 28, 7];
    //     } else if (monthNumbers[0] != monthNumbers[2] &&
    //         monthNumbers[0] == monthNumbers[1]) {
    //       weekNumbers = [21, 28, 7, 14];
    //     } else if (monthNumbers[0] != monthNumbers[1]) {
    //       weekNumbers = [28, 7, 14, 21];
    //     }

    //     debugPrint('weekNumbers: $weekNumbers');

    //     return SideTitleWidget(
    //       axisSide: meta.axisSide,
    //       child: Text(
    //         '${weekNumbers[value.toInt()]}/${date.month.toString().padLeft(2, '0')}',
    //         style: style,
    //       ),
    //     );
    //   }
    // }

    // Default format for other views (e.g., 7 days)
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}',
          style: style),
    );
  }
}
