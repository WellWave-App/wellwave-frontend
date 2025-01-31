import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/friend/data/repositories/friend_repositories.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_event.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/features/profile/data/models/profile_request_model.dart';
import 'package:wellwave_frontend/features/profile/data/repositories/profile_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUserAdd extends StatelessWidget {
  final String searchId;

  const ProfileUserAdd({super.key, required this.searchId});

  @override
  Widget build(BuildContext context) {
    debugPrint('test');
    return BlocProvider(
      create: (context) => FriendBloc(
        profileRepositories: ProfileRepositories(),
      )..add(SearchFriendEvent(searchId)),
      child: BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          if (state is FriendLoaded) {
            final profile = state.profile;
            String imageUrl = profile.imageUrl ?? '';
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage('${AppStrings.baseUrl}$imageUrl')
                      : AssetImage(AppImages.avatarDefaultIcon)
                          as ImageProvider<Object>,
                  radius: 52.0,
                ),
                SizedBox(height: 16),
                Text(
                  '${profile.username}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 16),
                CustomButtonSmall(
                  bgColor: AppColors.transparentColor,
                  outlineColor: AppColors.primaryColor,
                  textColor: AppColors.primaryColor,
                  title: 'เพิ่ม',
                  onPressed: () {
                    debugPrint('เพิ่มเพื่อน');
                  },
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
