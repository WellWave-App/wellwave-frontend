import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_event.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_state.dart';

import 'package:wellwave_frontend/features/health_assessment/widget/start_health_step.dart';

class AddPicUsernameStep extends StatelessWidget {
  final AssessmentState state;

  const AddPicUsernameStep({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.showStartStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => StartHealthStep()),
        );
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text("ตั้งชื่อและรูปผู้ใช้",
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text("ต้องการให้เราเรียกคุณว่าอะไรดี",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 64),
          Stack(
            children: [
              state.selectedImage != null
                  ? ClipOval(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.file(
                          state.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SvgPicture.asset(AppImages.avatarDefaultIcon),
              Positioned(
                bottom: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      context
                          .read<AssessmentBloc>()
                          .add(ImagePicked(File(pickedFile.path)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: SvgPicture.asset(AppImages.cameraIcon),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          CustomTextFormField(
            labelText: 'ชื่อผู้ใช้*',
            hintText: 'ชื่อผู้ใช้',
            initialValue: state.formData['username'] ?? '',
            inputFormatters: [
              LengthLimitingTextInputFormatter(16),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกชื่อผู้ใช้งาน';
              }
              return null;
            },
            onChanged: (value) => context
                .read<AssessmentBloc>()
                .add(UpdateField('username', value)),
          ),
        ],
      ),
    );
  }
}
