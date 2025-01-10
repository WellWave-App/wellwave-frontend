import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';

class UserInformation extends StatefulWidget {
  final String userID;
  final String userName;
  final int gemAmount;
  final int expAmount;
  final ProfileState state;

  const UserInformation(
      {Key? key,
      required this.userID,
      required this.userName,
      required this.gemAmount,
      required this.expAmount,
      required this.state})
      : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        Widget profileImage;

        if (state is ProfileLoaded && state.userProfile.imageUrl.isNotEmpty) {
          final imageUrl = "http://10.0.2.2:3000${state.userProfile.imageUrl}";
          profileImage = ClipOval(
            child: Image.network(
              imageUrl,
              width: 104,
              height: 104,
              fit: BoxFit.cover,
            ),
          );
        } else if (state.selectedImage != null) {
          profileImage = ClipOval(
            child: Image.file(
              state.selectedImage!,
              width: 104,
              height: 104,
              fit: BoxFit.cover,
            ),
          );
        } else {
          profileImage = const CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage(AppImages.crabImg),
          );
        }

        return Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                profileImage,
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(AppPages.editProfileName);
                    },
                    child: SvgPicture.asset(
                      AppImages.editProfileIcon,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${widget.userID}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.userID));

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('User ID copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      icon: SvgPicture.asset(AppImages.copyIcon),
                    )
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppImages.gemIcon,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.gemAmount}',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(),
                      ),
                      const SizedBox(width: 16),
                      SvgPicture.asset(
                        AppImages.expIcon,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.expAmount}',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
