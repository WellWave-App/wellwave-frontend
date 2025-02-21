import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/enums/thai_date_formatter.dart';
import 'package:wellwave_frontend/features/home/data/models/health_data_step_and_ex_respone_model.dart';

class CircularChartWidget extends StatelessWidget {
  final DateTime date;
  final HealthData healthData;
  final double dailyHabitGoal;
  final double dailyStepGoal;

  const CircularChartWidget({
    required this.date,
    required this.healthData,
    required this.dailyHabitGoal,
    required this.dailyStepGoal,
    Key? key,
  }) : super(key: key);

  double calculateHabitsCompletionForDay(
      List<HealthEntry> habits, DateTime date) {
    final dayHabits = habits
        .where((entry) =>
            DateTime.parse(entry.date).year == date.year &&
            DateTime.parse(entry.date).month == date.month &&
            DateTime.parse(entry.date).day == date.day)
        .toList();

    if (dayHabits.isEmpty) return 0.0;
    final completedHabits =
        dayHabits.fold(0, (sum, entry) => sum + entry.value);

    // print('Habits for ${DateFormat('E').format(date)}:');
    // for (var habit in dayHabits) {
    //   print('  - Value: ${habit.value}, Date: ${habit.date}');
    // }
    // print('Total Completed Habits: $completedHabits, $dailyHabitGoal');

    return (completedHabits / dailyHabitGoal).clamp(0.0, 1.0);
  }

  double calculateStepCompletionForDay(List<HealthEntry> steps, DateTime date) {
    final daySteps = steps
        .where((entry) =>
            DateTime.parse(entry.date).year == date.year &&
            DateTime.parse(entry.date).month == date.month &&
            DateTime.parse(entry.date).day == date.day)
        .toList();

    if (daySteps.isEmpty) return 0.0;

    final totalSteps = daySteps.fold(0, (sum, entry) => sum + entry.value);

    // print('Steps for ${DateFormat('E').format(date)}:');
    // for (var step in daySteps) {
    //   print('  - Value: ${step.value}, Date: ${step.date}');
    // }
    // print('Total Steps: $totalSteps, $dailyStepGoal');

    return (totalSteps / dailyStepGoal).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final habitsCompletion =
        calculateHabitsCompletionForDay(healthData.habits, date);
    final stepCompletion = calculateStepCompletionForDay(healthData.step, date);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ThaiDateFormatter.getThaiDayName(date),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.darkGrayColor,
              ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 26.0,
              lineWidth: 8.0,
              percent: habitsCompletion.clamp(0.0, 1.0),
              animation: false,
              progressColor: AppColors.darkPinkColor,
              backgroundColor: AppColors.lightgrayColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            CircularPercentIndicator(
              radius: 16.0,
              lineWidth: 6.0,
              percent: stepCompletion.clamp(0.0, 1.0),
              animation: false,
              progressColor: AppColors.secondaryDarkColor,
              backgroundColor: AppColors.lightgrayColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(habitsCompletion * 100).toInt().toString()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.darkPinkColor,
                  ),
            ),
            Text(
              '|',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightgrayColor,
                  ),
            ),
            Text(
              '${(stepCompletion * 100).toInt().toString()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryDarkColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
