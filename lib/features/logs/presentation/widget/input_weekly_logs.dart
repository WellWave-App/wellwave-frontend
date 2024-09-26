import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/logs_bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/scale_record_widget.dart';

class InputWeeklyLogs extends StatefulWidget {
  const InputWeeklyLogs({super.key});

  @override
  _InputWeeklyLogsState createState() => _InputWeeklyLogsState();
}

class _InputWeeklyLogsState extends State<InputWeeklyLogs> {
  int currentStep = 0;
  num weight = 50.5;
  num waistLine = 65.4;
  num hdl = 65.0;
  num ldl = 165.0;
  int selectedMood = 4;
  DateTime selectedDate = DateTime.now();

  final List<String> moodIconsGrey = [
    AppImages.verySadGreyIcon,
    AppImages.sadGreyIcon,
    AppImages.neutralGreyIcon,
    AppImages.happyGreyIcon,
    AppImages.veryHappyGreyIcon,
  ];

  final List<String> moodIconsColor = [
    AppImages.verySadColorIcon,
    AppImages.sadColorIcon,
    AppImages.neutralColorIcon,
    AppImages.happyColorIcon,
    AppImages.veryHappyColorIcon,
  ];

  final RulerPickerController weightController =
      RulerPickerController(value: 50.5);
  final RulerPickerController waistLineController =
      RulerPickerController(value: 65.4);
  final RulerPickerController hdlController =
      RulerPickerController(value: 65.0);
  final RulerPickerController ldlController =
      RulerPickerController(value: 165.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentStep == 5 ? '' : 'ขั้นตอนที่ ${currentStep + 1}/5',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (currentStep == 2 || currentStep == 3)
            TextButton(
              onPressed: () {
                setState(() {
                  currentStep++; // ไปยังขั้นตอนถัดไป
                });
              },
              child: Text(
                AppStrings.skipText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyColor,
                    ),
              ),
            ),
        ],
      ),
      content: _buildStepContent(),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildActions(),
        ),
      ],
      backgroundColor: AppColors.popupColor,
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return ScaleRecordWidget(
          title: AppStrings.weightRecordText,
          label: AppStrings.kgText,
          initialValue: weight,
          controller: weightController,
          onValueChanged: (value) {
            setState(() {
              weight = value;
            });
          },
        );

      case 1:
        return ScaleRecordWidget(
          title: AppStrings.waistLineRecordText,
          label: AppStrings.cmText,
          initialValue: waistLine,
          controller: waistLineController,
          onValueChanged: (value) {
            setState(() {
              waistLine = value;
            });
          },
        );

      case 2:
        return ScaleRecordWidget(
          title: AppStrings.hdlRecordText,
          label: AppStrings.mgPerDlText,
          initialValue: hdl,
          controller: hdlController,
          onValueChanged: (value) {
            setState(() {
              hdl = value;
            });
          },
        );

      case 3:
        return ScaleRecordWidget(
          title: AppStrings.ldlRecordText,
          label: AppStrings.mgPerDlText,
          initialValue: ldl,
          controller: ldlController,
          onValueChanged: (value) {
            setState(() {
              ldl = value;
            });
          },
        );
      case 4:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.chooseMoodsText,
                  style: Theme.of(context).textTheme.title320?.copyWith(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(moodIconsGrey.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = index;
                    });
                  },
                  child: SvgPicture.asset(
                    selectedMood == index
                        ? moodIconsColor[index] // Use color icon if selected
                        : moodIconsGrey[index], // Use grey icon if not selected
                    width: 48, // Adjust size of the SVG
                    height: 48,
                  ),
                );
              }),
            )
          ],
        );
      case 5:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppImages.completeIcon,
              width: 80, // Set the width
              height: 80, // Set the height
            ),
            const SizedBox(height: 8), // Space between the SVG and text
            Text(AppStrings.dataRecordingCompletedText,
                style: Theme.of(context).textTheme.labelLarge?.copyWith())
          ],
        );
      default:
        return Container();
    }
  }

  List<Widget> _buildActions() {
    return [
      Expanded(
        child: TextButton(
          onPressed: () {
            if (currentStep == 5) {
              BlocProvider.of<LogsBloc>(context).add(
                SubmitLogEvent(
                  logName:
                      'WEIGHT_LOG', 
                  value: weight.toInt(), 
                  selectedDate: selectedDate.toIso8601String(),
                ),
              );
              BlocProvider.of<LogsBloc>(context).add(
                SubmitLogEvent(
                  logName:
                      'WAIST_LINE_LOG', 
                  value: waistLine.toInt(), 
                  selectedDate: selectedDate.toIso8601String(),
                ),
              );

              BlocProvider.of<LogsBloc>(context).add(
                SubmitLogEvent(
                  logName: 'HDL_LOG', 
                  value: hdl.toInt(), 
                  selectedDate: selectedDate.toIso8601String(),
                ),
              );

              BlocProvider.of<LogsBloc>(context).add(
                SubmitLogEvent(
                  logName: 'LDL_LOG', // for LDL
                  value: ldl.toInt(), // Send the selected LDL value
                  selectedDate: selectedDate.toIso8601String(),
                ),
              );

              // Once submission is done, you can navigate or show a confirmation message
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            ),
            backgroundColor: WidgetStateProperty.all(currentStep == 5
                ? AppColors.primaryColor
                : Colors.transparent), // Blue if finished
            side: WidgetStateProperty.all(
                const BorderSide(color: AppColors.primaryColor)), // Blue border
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // Rounded corners
              ),
            ),
          ),
          child: Text(
              currentStep == 5
                  ? AppStrings.completedText
                  : AppStrings.cancleText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: currentStep == 5
                      ? Colors.white
                      : AppColors.primaryColor)),
        ),
      ),
      const SizedBox(width: 8),

      // Next or Confirm Button
      if (currentStep < 5)
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                // Save the controller values when the "Next" button is pressed
                if (currentStep == 0) {
                  weight = weightController.value; // Save updated weight value
                  debugPrint("Selected weight: $weight");
                } else if (currentStep == 1) {
                  waistLine =
                      waistLineController.value; // Save weight line value
                  debugPrint("Selected waist line: $waistLine");
                } else if (currentStep == 2) {
                  hdl = hdlController.value; // Save updated HDL value
                  debugPrint("Selected HDL: $hdl");
                } else if (currentStep == 3) {
                  ldl = ldlController.value; // Save updated LDL value
                  debugPrint("Selected LDL: $ldl");
                }
                currentStep++; // Move to the next step
              });
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              ),
              backgroundColor: WidgetStateProperty.all(
                  AppColors.primaryColor), // Blue background
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // Rounded corners
                ),
              ),
            ),
            child: Text(
              currentStep == 4 ? AppStrings.confirmText : AppStrings.nextText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white), // White text color for blue buttons
            ),
          ),
        ),
    ];
  }
}
