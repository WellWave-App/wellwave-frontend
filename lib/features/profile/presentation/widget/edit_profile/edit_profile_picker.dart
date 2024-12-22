import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/constants/app_images.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';

class EditProfileImage extends StatefulWidget {
  final ProfileState state;

  const EditProfileImage({super.key, required this.state});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      debugPrint("Picked file path: ${pickedFile.path}");
      context.read<ProfileBloc>().add(ImagePicked(File(pickedFile.path)));
    } else {
      debugPrint("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // debugPrint("Current state: $state");

        Widget profileImage;

        if (state is ProfileLoaded && state.userProfile.imageUrl.isNotEmpty) {
          final imageUrl = "http://10.0.2.2:3000${state.userProfile.imageUrl}";
          profileImage = ClipOval(
            child: Image.network(
              imageUrl,
              width: 128,
              height: 128,
              fit: BoxFit.cover,
            ),
          );
        } else if (state.selectedImage != null) {
          profileImage = ClipOval(
            child: Image.file(
              state.selectedImage!,
              width: 128,
              height: 128,
              fit: BoxFit.cover,
            ),
          );
        } else {
          profileImage = const CircleAvatar(
            radius: 64,
            backgroundImage: AssetImage(AppImages.crabImg),
          );
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: profileImage,
            ),
            Positioned(
              child: GestureDetector(
                onTap: _pickImage,
                child: SvgPicture.asset(AppImages.editUserProfileSvg),
              ),
            ),
          ],
        );
      },
    );
  }
}
