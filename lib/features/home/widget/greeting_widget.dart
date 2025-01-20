import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/enums/greeting_message.dart';
import 'package:wellwave_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:wellwave_frontend/features/home/widget/top_of_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({super.key});

  @override
  _GreetingWidgetState createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  late String greetingMessage;
  late String dailyMessage;

  @override
  void initState() {
    super.initState();
    greetingMessage = GreetingTimeText.getGreetingMessage();
    dailyMessage = DailyMessage().getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          TopOfScreen(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$greetingMessage, แจน',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      Text(
                        '$dailyMessage',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '10',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'วันต่อเนื่อง',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppImages.fireIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                AppImages.avatarImage,
                height: 120,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
