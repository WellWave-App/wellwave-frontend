import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:wellwave_frontend/features/home/widget/action_slider_button.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/config/constants/enums/thai_date_formatter.dart';
import 'package:wellwave_frontend/features/home/data/models/progress.dart';
import 'package:intl/intl.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/gradient_button.dart';

class ProgressStepperWidget extends StatelessWidget {
  final Progress progress;
  final String progressId;

  ProgressStepperWidget({required this.progress, required this.progressId});

  List<DateTime> _generateDates(Progress progress) {
    return List.generate(
      progress.totalDays,
      (index) => progress.startDate.add(Duration(days: index)),
    );
  }

  List<DateTime> _getVisibleDates(List<DateTime> dates, DateTime activeDate) {
    final activeIndex =
        dates.indexWhere((date) => _isSameDay(date, activeDate));

    // หากไม่พบวันที่ active ให้เริ่มจาก index 0
    if (activeIndex == -1) return dates.take(4).toList();

    // ให้วันที่ active อยู่ตำแหน่งที่ 3 ของ visibleDates
    int startIndex = activeIndex - 2;

    // ตรวจสอบขอบเขตด้านซ้าย
    if (startIndex < 0) {
      startIndex = 0;
    }
    // ตรวจสอบขอบเขตด้านขวา
    else if (startIndex + 4 > dates.length) {
      startIndex = dates.length - 4;
    }

    return dates.skip(startIndex).take(4).toList();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final dates = _generateDates(progress);
        final activeDate = DateTime.now();
        final visibleDates = _getVisibleDates(dates, activeDate);

        if (visibleDates.isEmpty) {
          return SizedBox.shrink();
        }

        final stepNumber =
            visibleDates.indexWhere((date) => _isSameDay(date, activeDate)) + 1;

        final visibleDate = stepNumber > 0 && stepNumber <= visibleDates.length
            ? visibleDates[stepNumber - 1]
            : visibleDates.first;

        return Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < visibleDates.length; i++) ...[
                  _buildStep(
                    i + 1,
                    visibleDates[i],
                    context,
                    visibleDates,
                    context.read<HomeBloc>(),
                    progress.dailyCompletion ?? {},
                    progressId,
                  ),
                ],
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: progress.activityType == 'exercise'
                  ? GradientButton(
                      text: 'ทำภารกิจ',
                      onPressed: () {
                        context.goNamed(AppPages.missionPage);
                      },
                    )
                  : ActionSliderButton(
                      stepNumber: stepNumber,
                      date: visibleDate,
                      progressId: progressId,
                    ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildStep(
    int stepNumber,
    DateTime date,
    BuildContext context,
    List<DateTime> visibleDates,
    HomeBloc bloc,
    Map<String, dynamic> dailyCompletion,
    String progressId) {
  bool isComplete = bloc.completionStatus[progressId]?[date] ?? false;
  bool isActive = _isSameDay(date, DateTime.now());

  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepCircle(
                  isComplete, isActive, date, context, dailyCompletion),
              if (stepNumber < visibleDates.length)
                _buildStepConnector(visibleDates.length),
            ],
          ),
          SizedBox(height: 4),
          Container(
            width: 30,
            child: Text(
              ThaiDateFormatter.getThaiDayName(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.bluegrayColor,
                  ),
            ),
          ),
          SizedBox(height: 48),
        ],
      ),
    ],
  );
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Widget _buildStepCircle(bool isComplete, bool isActive, DateTime date,
    BuildContext context, Map<String, dynamic> dailyCompletion) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: isComplete
            ? AppColors.skyblueColor
            : isActive
                ? AppColors.darkSkyBlueColor
                : AppColors.lightgrayColor,
        width: 4.0,
      ),
    ),
    child: CircleAvatar(
      radius: 10,
      backgroundColor: isComplete
          ? AppColors.skyblueColor
          : isActive
              ? AppColors.skyblueColor
              : AppColors.lightgrayColor,
      child: isComplete
          ? Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : dailyCompletion[date.toString()] == false
              ? Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 16,
                )
              : Text(
                  '${date.day}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
    ),
  );
}

Widget _buildStepConnector(int totalSteps) {
  double width;
  switch (totalSteps) {
    case 2:
      width = 106;
      break;
    case 3:
      width = 39;
      break;
    default:
      width = 16;
  }

  return Container(
    height: 4,
    width: width,
    color: AppColors.lightgrayColor,
  );
}
