import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_state.dart';

import '../../../../../config/constants/app_images.dart';
import '../../../../../config/constants/app_pages.dart';
import '../../bloc/profile_bloc.dart';

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
  //     context.read<ProfileBloc>().add(ImagePicked(imageFile));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        
        
        // if (state is ProfileSelectImageState) {
          return Stack(
            
            alignment: Alignment.bottomCenter,
            //new
            // children: [
            //   const Padding(
            //     padding: EdgeInsets.only(bottom: 10),
            //   ),
            //   state.selectedImage != null
            //       ? ClipOval(
            //           child: SizedBox(
            //             width: 64,
            //             height: 64,
            //             child: Image.file(
            //               state.selectedImage!,
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
        // else if (state is ProfileLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }
      //   return Container();
      // },
    );
  }
}
