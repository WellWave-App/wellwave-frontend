import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/constants/app_images.dart';
import '../../../../config/constants/app_pages.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({Key? key}) : super(key: key);

  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  // File? _imageFile;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(bottom: 10),
    //       child: CircleAvatar(
    //         radius: 64,
    //         backgroundImage: _imageFile != null
    //             ? FileImage(_imageFile!)
    //             : const AssetImage(AppImages.crabImg) as ImageProvider,
    //       ),
    //     ),
    //     Positioned(
    //       child: GestureDetector(
    //         onTap: _pickImage, // When tapped, open image picker
    //         child: SvgPicture.asset(
    //           AppImages.editUserProfileSvg,
    //           width: 40, // You can adjust the size of the SVG icon
    //           height: 40,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Stack(
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
