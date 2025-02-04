import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final extension = path.extension(pickedFile.path).toLowerCase();
        if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
          final file = File(pickedFile.path);
          if (await file.exists()) {
            // print('Selected image file exists at: ${file.path}');
            // print('File extension: $extension');
            // print('File size: ${await file.length()} bytes');
            context.read<ProfileBloc>().add(ImagePicked(file));
          } else {
            // print('Selected file does not exist at path: ${file.path}');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a JPG, PNG, or GIF image'),
            ),
          );
        }
      }
    } catch (e) {
      // print('Error picking image: $e');
      // print('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error selecting image. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        Widget profileImage;
        if (state is ProfileLoaded) {
          if (state.selectedImage != null &&
              state.selectedImage!.existsSync()) {
            profileImage = ClipOval(
              child: Image.file(
                state.selectedImage!,
                width: 128,
                height: 128,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // print('Error loading selected image: $error');
                  return _buildDefaultImage();
                },
              ),
            );
          } else if (state.userProfile.imageUrl.isNotEmpty) {
            final imageUrl =
                "http://10.0.2.2:3000${state.userProfile.imageUrl}";
            // print('Loading network image from: $imageUrl');
            profileImage = ClipOval(
              child: Image.network(
                imageUrl,
                width: 128,
                height: 128,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  // print('Error loading network image: $error');
                  // print('Stack trace: $stackTrace');
                  return _buildDefaultImage();
                },
              ),
            );
          } else {
            profileImage = _buildDefaultImage();
          }
        } else {
          profileImage = _buildDefaultImage();
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

  Widget _buildDefaultImage() {
    return const CircleAvatar(
      radius: 64,
      backgroundImage: AssetImage(AppImages.crabImg),
    );
  }
}
