import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';

class LineChartSample2 extends StatelessWidget {
  final String logType;

  const LineChartSample2({super.key, required this.logType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        if (state is LogsLoadGraphInProgress) {
          // Remove this loading indicator to avoid multiple spinners
          return Container(); // You can display something else here if needed
        } else if (state is LogsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is LogsLoadGraphSuccess) {
          // Fetch logs based on logType
          List<dynamic> logs = logType == "WEIGHT_LOG"
              ? state.logsWeightlist
              : state.logsWaistLinelist;

          if (logs.isEmpty) {
            return const Center(child: Text('No logs available'));
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
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  child: LineChart(
                    mainData(logs, minY, maxY),
                  ),
                ),
              ),
            ],
          );
        }

        return Container(); // Return an empty container by default
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
        getDrawingVerticalLine: (value) => const FlLine(color: Color(0xFFB1B1B1), strokeWidth: 0.5),
      ),
      titlesData: FlTitlesData(
        show: true,
        
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(logs, value, meta),
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
            return FlSpot(index.toDouble(), log != null ? log.value.toDouble() : 0);
          }).toList(),
          isCurved: true,
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
    if (value.toInt() < logs.length) {
      final log = logs[value.toInt()];
      final date = DateTime.parse(log.date.toIso8601String());
      final formattedDate = '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      return SideTitleWidget(axisSide: meta.axisSide, child: Text(formattedDate, style: style));
    }
    return const Text('-', style: style);
  }
}
