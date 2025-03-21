import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';

class UserInformation extends StatefulWidget {
  final String userID;
  final String userName;
  final int gemAmount;
  final int expAmount;
  // final ProfileState state;

  const UserInformation({
    Key? key,
    required this.userID,
    required this.userName,
    required this.gemAmount,
    required this.expAmount,
    // required this.state
  }) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendBloc, FriendState>(
      builder: (context, state) {
        Widget profileImage;
        profileImage = CircleAvatar(
          radius: 52,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            AppImages.avatarDefaultIcon,
          ),
        );
        // if (
        //     state is ProfileLoaded &&
        //     state.userProfile.imageUrl.isNotEmpty) {
        //   final imageUrl = "http://10.0.2.2:3000${state.userProfile.imageUrl}";
        //   profileImage = ClipOval(
        //     child: Image.network(
        //       imageUrl,
        //       width: 104,
        //       height: 104,
        //       fit: BoxFit.cover,
        //     ),
        //   );
        // } else if (state.selectedImage != null) {
        //   profileImage = ClipOval(
        //     child: Image.file(
        //       state.selectedImage!,
        //       width: 104,
        //       height: 104,
        //       fit: BoxFit.cover,
        //     ),
        //   );
        // } else {
        //   profileImage = const CircleAvatar(
        //     radius: 52,
        //     backgroundImage: AssetImage(AppImages.crabImg),
        //   );

        return Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                profileImage,
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
                const SizedBox(height: 4),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '#${widget.userID}',
                //       style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                //     ),
                //   ],
                // ),
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
                const SizedBox(height: 8),
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
                        AppImages.actionIcon,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${AppStrings.leagueText}ไดมอนด์',
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
