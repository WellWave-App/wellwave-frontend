import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/common/widget/rectangle_box.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  AssessmentScreenState createState() => AssessmentScreenState();
}

class AssessmentScreenState extends State<AssessmentScreen> {
  int _currentStep = 0;

  void onBackPressed() {
    if (_currentStep == 0) {
      Navigator.of(context).pop(); // Go back to the previous route
    } else {
      setState(() {
        _currentStep--; // go back step
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        onLeading: true,
        textColor: Colors.black,
        backgroundColor: Colors.transparent,
        onBackPressed: onBackPressed,
      ),
      body: Container(
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: _currentStep + 1,
              size: 4,
              selectedColor: AppColors.primaryColor,
              unselectedColor: AppColors.lightgrayColor,
            ),
            Expanded(
              child: StepContent(currentStep: _currentStep),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _currentStep < 7 ? continued : null,
                  child: _currentStep == 0
                      ? const Text('เข้าสู่แบบประเมิน')
                      : _currentStep == 6
                          ? const Text('เสร็จสิ้น')
                          : const Text('ถัดไป'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void continued() {
    setState(() {
      if (_currentStep < 6) {
        _currentStep++;
      }
    });
  }

  void cancel() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }
}

class StepContent extends StatefulWidget {
  final int currentStep;

  const StepContent({super.key, required this.currentStep});

  @override
  _StepContentState createState() => _StepContentState();
}

class _StepContentState extends State<StepContent> {
  String selectedGender = '';

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    double containerWidth = MediaQuery.of(context).size.width / 2 - 24;

    switch (widget.currentStep) {
      case 0:
        return Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  AppImages.healthassessmentImg,
                  width: MediaQuery.of(context).size.width - 100,
                ),
                const SizedBox(
                  height: 48,
                ),
                Text(
                  "แบบประเมินสุขภาพ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "คัดกรองความเสี่ยงในกลุ่มภาวะโรคเมตาบอลิก \n(เบาหวาน ความดันโลหิตสูง ไขมัน และโรคอ้วน)",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );

      case 1:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              children: <Widget>[
                Text("ตั้งชื่อและรูปผู้ใช้",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 8,
                ),
                Text("ต้องการให้เราเรียกคุณว่าอะไรดี",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 72,
                ),
                Stack(
                  children: [
                    _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : SvgPicture.asset(AppImages.avatarDefaultIcon),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: _pickImageFromGallery,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(12),
                        ),
                        child: SvgPicture.asset(AppImages.cameraIcon),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 72,
                ),
                CustomTextFormField(
                  labelText: 'ชื่อผู้ใช้',
                ),
              ],
            ),
          ),
        );

      case 2:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Text(
                        "ข้อมูลส่วนตัว",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                ),
                Text(
                  'เพศ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors
                            .bluegrayColor, // Set your desired label color here
                      ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Male Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = 'male';
                        });
                      },
                      child: Column(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              selectedGender == 'male'
                                  ? Colors.transparent
                                  : AppColors.grayColor,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(
                              AppImages.maleImage,
                              width: containerWidth,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'ชาย',
                            style: TextStyle(
                              color: selectedGender == 'male'
                                  ? Colors.black
                                  : AppColors.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Female Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = 'female';
                        });
                      },
                      child: Column(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              selectedGender == 'female'
                                  ? Colors.transparent
                                  : AppColors.grayColor,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(
                              AppImages.femaleImage,
                              width: containerWidth,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'หญิง',
                            style: TextStyle(
                              color: selectedGender == 'female'
                                  ? Colors.black
                                  : AppColors.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  labelText: 'ปีเกิด (พ.ศ.)',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  labelText: 'ส่วนสูง',
                  suffixText: 'ซม.',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  labelText: 'น้ำหนัก',
                  suffixText: 'กก.',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        );
      case 3:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text("ข้อมูลสุขภาพ",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 8,
                ),
                Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  labelText: 'ความดันโลหิตขณะบีบตัว',
                  suffixText: 'มิลลิเมตรปรอท',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  labelText: 'ความดันโลหิตขณะคลายตัว',
                  suffixText: 'มิลลิเมตรปรอท',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  labelText: 'รอบเอว',
                  suffixText: 'ซม.',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  labelText: 'น้ำตาลในเลือด',
                  suffixText: 'มก./ดล.',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  labelText: 'ไขมันในเลือด Cholesterol',
                  suffixText: 'มก./ดล.',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  labelText: 'ไขมันในเลือด Triglyceride',
                  suffixText: 'มก./ดล.',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        );
      case 4:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text(
                  "ประวัติเจ็บป่วยในครอบครัว",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "โรคความดัน\nโลหิตสูง"),
                    Rectangle_box(title: "โรคไขมันใน\nหลอดเลือดผิดปกติ"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "โรคหลอดเลือด\nหัวใจ"),
                    Rectangle_box(title: "โรค\nเบาหวาน"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "โรค\nอัมพาต"),
                    Rectangle_box(title: "ไม่ทราบ / \nไม่มีประวัติเจ็บป่วย"),
                  ],
                ),
              ],
            ),
          ),
        );
      case 5:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text(
                  "การดื่มเครื่องดื่มแอลกอฮอล์",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "ดื่มเป็นประจำ\n(>5 ครั้ง/สัปดาห์)"),
                    Rectangle_box(title: "ดื่มเป็นครั้งคราว"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "เคยดื่มแต่เลิกแล้ว"),
                    Rectangle_box(title: "ไม่ดื่มแอลกอฮอล์"),
                  ],
                ),
              ],
            ),
          ),
        );
      case 6:
        return Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text(
                  "การสูบบุหรี่",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("บอกข้อมูลของคุณให้เราทราบเพื่อผลลัพธ์ที่แม่นยำ",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "สูบเป็นประจำ"),
                    Rectangle_box(title: "เลิกสูบแล้ว"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rectangle_box(title: "ไม่สูบ"),
                  ],
                ),
              ],
            ),
          ),
        );
      default:
        return const Text('Default');
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}
