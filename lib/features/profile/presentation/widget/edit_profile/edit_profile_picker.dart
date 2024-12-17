import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_state.dart';

import '../../../../../config/constants/app_images.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';

class EditProfileImage extends StatefulWidget {
  final ProfileState state;

  const EditProfileImage({super.key, required this.state});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
  // _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  //new
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      context.read<ProfileBloc>().add(ImagePicked(imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            if (state is ProfileSelectImageState && state.selectedImage != null)
              ClipOval(
                child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.file(
                    state.selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage(AppImages.crabImg),
                ),
              ),
            Positioned(
              child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: SvgPicture.asset(
                  AppImages.editUserProfileSvg,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
