import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/mission/presentation/widgets/success_popup.dart';

class MissionPopup extends StatelessWidget {
  final String missionName;
  final Widget? duration;
  final List<String> completedDays;
  final int reward;
  final Widget? receiveText;
  final Widget? goalMission;

  const MissionPopup({
    super.key,
    required this.missionName,
    this.duration,
    required this.completedDays,
    required this.reward,
    this.receiveText,
    this.goalMission,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SlideActionState> _key = GlobalKey();

    return AlertDialog(
      title: Text(missionName, style: Theme.of(context).textTheme.titleLarge),
      content: SizedBox(
        width: 300, 
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: duration,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: receiveText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 48),
                child: Row(
                  children: [
                    Image.asset(AppImages.expImage),
                    Text(
                      ' x15',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SlideAction(
          key: _key,
          outerColor: AppColors.secondaryDarkColor,
          text: AppStrings.slideForSuccessText,
          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.whiteColor,
              ),
          sliderButtonIcon: Row(
            children: [SvgPicture.asset(AppImages.arrowForwardIcon)],
          ),
          onSubmit: () {
          
            Navigator.of(context).pop();

            
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Dialog(
                  backgroundColor: Colors.transparent,
                  child: SuccessPopup(),
                );
              },
            );

            Future.delayed(
              const Duration(seconds: 1),
              () {
            
                if (_key.currentState != null) {
                  _key.currentState!.reset();
                }
              },
            );
            return null;
          },
          elevation: 24,
        ),
      ],
    );
  }
}



// Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SvgPicture.asset(AppImages.calendarIcon),
//                 const SizedBox(width: 8),
//                 const Text('5 วัน'),
//                 const SizedBox(width: 16),
//                 SvgPicture.asset(AppImages.clockIcon),
//                 const SizedBox(width: 8),
//                 const Text('10 นาที'),
//               ],
//             ),

// Text(AppStrings.setDayText)