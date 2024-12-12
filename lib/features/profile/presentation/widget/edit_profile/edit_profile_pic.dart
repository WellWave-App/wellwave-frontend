import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';

import '../../../../../config/constants/app_images.dart';
import '../../../../../config/constants/app_pages.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({Key? key}) : super(key: key);

  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  //new
  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     final File imageFile = File(pickedFile.path);
  //     context.read<HealthAssessmentPageBloc>().add(ImagePicked(imageFile));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //new
      // children: [
      //   widget.state.selectedImage != null
      //       ? ClipOval(
      //           child: SizedBox(
      //             width: 176,
      //             height: 176,
      //             child: Image.file(
      //               widget.state.selectedImage!,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         )
      //       : SvgPicture.asset(AppImages.crabImg),
      //   Positioned(
      //     bottom: 0,
      //     right: 0,
      //     child: ElevatedButton(
      //       onPressed: _pickImage,
      //       style: ElevatedButton.styleFrom(
      //         shape: const CircleBorder(),
      //         padding: const EdgeInsets.all(12),
      //       ),
      //       child: SvgPicture.asset(AppImages.editUserProfileSvg),
      //     ),
      //   ),
      // ],



      //old
      alignment: Alignment.bottomCenter,
      children: [
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
              context.goNamed(AppPages.editProfileName);
            },
            child: SvgPicture.asset(
              AppImages.editUserProfileSvg,
            ),
          ),
        )
      ],
    );
  }
}
