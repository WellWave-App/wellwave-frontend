import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_event.dart';

class PersonalInfoStep extends StatelessWidget {
  const PersonalInfoStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AssessmentBloc>().state;
    final containerWidth = MediaQuery.of(context).size.width / 2 - 24;

    return Expanded(
      child: SingleChildScrollView(
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
                    height: 12,
                  ),
                  Text(
                    "บอกข้อมูลของคุณ เพื่อผลลัพธ์ที่แม่นยำ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
            Text(
              'เพศ*',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.bluegrayColor,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<AssessmentBloc>()
                        .add(UpdateField('gender', 'male'));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        state.formData['gender'] == 'male'
                            ? AppImages.maleImage
                            : AppImages.maleImageUnselected,
                        width: containerWidth,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'ชาย',
                        style: TextStyle(
                          color: state.formData['gender'] == 'male'
                              ? Colors.black
                              : AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<AssessmentBloc>()
                        .add(UpdateField('gender', 'female'));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        state.formData['gender'] == 'female'
                            ? AppImages.femaleImage
                            : AppImages.femaleImageUnselected,
                        width: containerWidth,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'หญิง',
                        style: TextStyle(
                          color: state.formData['gender'] == 'female'
                              ? Colors.black
                              : AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (state.genderError)
              Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'กรุณากรอกเพศของคุณ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFBE4B43),
                        ),
                  ),
                ],
              ),
            const SizedBox(
              height: 24,
            ),
            CustomTextFormField(
              labelText: 'ปีเกิด (พ.ศ.)*',
              hintText: 'ปีเกิด',
              keyboardType: TextInputType.number,
              initialValue: state.formData['birthYear'] ?? '',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกปีเกิด';
                } else {
                  int birthYear = int.tryParse(value) ?? 0;
                  int currentYear = DateTime.now().year + 543;
                  int minYear = currentYear - 120;
                  if (birthYear < minYear || birthYear > currentYear) {
                    return 'กรุณากรอกปีพุทธศักราช';
                  }
                }
                return null;
              },
              onChanged: (value) => context
                  .read<AssessmentBloc>()
                  .add(UpdateField('birthYear', value)),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomTextFormField(
              labelText: 'ส่วนสูง*',
              hintText: 'ส่วนสูง',
              suffixText: 'ซม.',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              keyboardType: TextInputType.number,
              initialValue: state.formData['height'] ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกส่วนสูง';
                }

                int? height = int.tryParse(value);
                if (height == null) {
                  return 'กรุณากรอกเฉพาะตัวเลข';
                } else if (height > 200) {
                  return 'กรุณากรอกส่วนสูงที่ถูกต้อง';
                }

                return null;
              },
              onChanged: (value) => context
                  .read<AssessmentBloc>()
                  .add(UpdateField('height', value)),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomTextFormField(
              labelText: 'น้ำหนัก*',
              hintText: 'น้ำหนัก',
              suffixText: 'กก.',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              initialValue: state.formData['weight'] ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณากรอกน้ำหนัก';
                }

                int? weight = int.tryParse(value);
                if (weight == null) {
                  return 'กรุณากรอกเฉพาะตัวเลข';
                } else if (weight > 300) {
                  return 'กรุณากรอกน้ำหนักที่ถูกต้อง';
                }

                return null;
              },
              onChanged: (value) => context
                  .read<AssessmentBloc>()
                  .add(UpdateField('weight', value)),
            ),
          ],
        ),
      ),
    );
  }
}
