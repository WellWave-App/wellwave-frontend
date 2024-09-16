import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class InputWeeklyLogs extends StatefulWidget {
  const InputWeeklyLogs({super.key});

  @override
  _InputWeeklyLogsState createState() => _InputWeeklyLogsState();
}

class _InputWeeklyLogsState extends State<InputWeeklyLogs> {
  int currentStep = 0;
  num weight = 50.0;
  num hdl = 60.0;
  num ldl = 100.0;
  int selectedMood = 4;

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
      RulerPickerController(value: 50.0);
  final RulerPickerController hdlController =
      RulerPickerController(value: 60.0);
  final RulerPickerController ldlController =
      RulerPickerController(value: 100.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentStep == 4 ? '' : 'ขั้นตอนที่ ${currentStep + 1}/4',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (currentStep == 1 || currentStep == 2)
            TextButton(
              onPressed: () {
                setState(() {
                  currentStep++; // ไปยังขั้นตอนถัดไป
                });
              },
              child: const Text(
                AppStrings.skipText,
                style: TextStyle(
                  color: AppColors.greyColor, // สีเทาเข้ม
                  fontWeight: FontWeight.normal,
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.weightRecordText),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$weight ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text(AppStrings.kgText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: weightController,
              onValueChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
              ranges: const [
                RulerRange(begin: 30, end: 150, scale: 0.5),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.hdlRecordText),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$hdl ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text(AppStrings.mgPerDlText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: hdlController,
              onValueChanged: (value) {
                setState(() {
                  hdl = value;
                });
              },
              ranges: const [
                RulerRange(begin: 0, end: 100, scale: 1),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.ldlRecordText),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$ldl ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold)),
                Text(AppStrings.mgPerDlText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.greyColor,
                        )),
              ],
            ),
            RulerPicker(
              controller: ldlController,
              onValueChanged: (value) {
                setState(() {
                  ldl = value;
                });
              },
              ranges: const [
                RulerRange(begin: 0, end: 200, scale: 1),
              ],
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              rulerBackgroundColor: Colors.transparent,
              onBuildRulerScaleText: (index, value) {
                return value.toStringAsFixed(1);
              },
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.chooseMoodsText),
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
      case 4:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display the SVG
            SvgPicture.asset(
              AppImages.completeIcon,
              width: 80, // Set the width
              height: 80, // Set the height
            ),
            const SizedBox(height: 8), // Space between the SVG and text
            Text(AppStrings.dataRecordingCompletedText,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.blackColor, fontWeight: FontWeight.bold))
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
            if (currentStep == 4) {
              Navigator.pop(context);
            } else {
              setState(() {
                currentStep = 0;
              });
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(currentStep == 4
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
            currentStep == 4 ? AppStrings.completedText : AppStrings.cancleText,
            style: TextStyle(
                color: currentStep == 4
                    ? Colors.white
                    : AppColors
                        .primaryColor), // Change text color based on state
          ),
        ),
      ),
      const SizedBox(width: 8),
      // Next or Confirm Button
      if (currentStep < 4)
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                currentStep++;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  AppColors.primaryColor), // Blue background
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // Rounded corners
                ),
              ),
            ),
            child: Text(
              currentStep == 3 ? AppStrings.confirmText : AppStrings.nextText,
              style: const TextStyle(
                  color: Colors.white), // White text color for blue buttons
            ),
          ),
        ),
    ];
  }
}
