import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/health_assessment/widget/start_health_step.dart';

import '../../presentation/bloc/health_assessment_page/health_assessment_page_bloc.dart';
import '../../presentation/bloc/health_assessment_page/health_assessment_page_event.dart';
import '../../presentation/bloc/health_assessment_page/health_assessment_page_state.dart';

class AddPicUsernameStep extends StatefulWidget {
  final HealthAssessmentPageState state;

  const AddPicUsernameStep({super.key, required this.state});

  @override
  State<AddPicUsernameStep> createState() => _AddPicUsernameStepState();
}

class _AddPicUsernameStepState extends State<AddPicUsernameStep> {
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      context.read<HealthAssessmentPageBloc>().add(ImagePicked(imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.showStartStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => const StartHealthStep()),
        );
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(AppStrings.setNameandPicText,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(AppStrings.callNameAskText,
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 64),
          Stack(
            children: [
              widget.state.selectedImage != null
                  ? ClipOval(
                      child: SizedBox(
                        width: 176,
                        height: 176,
                        child: Image.file(
                          widget.state.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SvgPicture.asset(AppImages.avatarDefaultIcon),
              Positioned(
                bottom: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: _pickImage,
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
            labelText: "ชื่อผู้ใช้*",
            hintText: AppStrings.usernameText,
            initialValue: widget.state.formData['username'] ?? '',
            inputFormatters: [
              LengthLimitingTextInputFormatter(16),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณากรอกชื่อผู้ใช้';
              }
              return null;
            },
            onChanged: (value) => context
                .read<HealthAssessmentPageBloc>()
                .add(UpdateField('username', value)),
          ),
        ],
      ),
    );
  }
}
