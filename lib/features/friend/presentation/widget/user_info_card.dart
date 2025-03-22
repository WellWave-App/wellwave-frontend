import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/config/constants/app_url.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_bloc.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_event.dart';
import 'package:wellwave_frontend/features/friend/presentation/bloc/friend_state.dart';
import 'package:wellwave_frontend/config/constants/enums/thai_date_formatter.dart';

class UserInfoCard extends StatelessWidget {
  final String uid;
  final String? username;
  final String? imageUrl;
  final int steps;
  final int sleepHours;
  final String? lastLogin;

  const UserInfoCard({
    Key? key,
    required this.uid,
    this.username,
    this.imageUrl,
    required this.steps,
    required this.sleepHours,
    this.lastLogin,
  }) : super(key: key);

  Widget _buildWaveIcon(BuildContext context) {
    return BlocBuilder<FriendBloc, FriendState>(
      builder: (context, state) {
        return FutureBuilder<bool>(
          future: _getWaveStatus(),
          builder: (context, snapshot) {
            bool isWaveActive = snapshot.data ?? false;

            return GestureDetector(
              onTap: () async {
                if (!isWaveActive) {
                  await _setWaveStatus(true);
                  context.read<FriendBloc>().add(ToggleWaveIconEvent());
                }
              },
              child: SvgPicture.asset(
                isWaveActive ? AppImages.waveIconActive : AppImages.waveIcon,
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _getWaveStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateTime.now().toString().split(' ')[0];
    final String? lastWaveDate = prefs.getString('last_wave_date');

    if (lastWaveDate != today) {
      await prefs.setBool('is_wave_active', false);
      await prefs.setString('last_wave_date', today);
      return false;
    }

    return prefs.getBool('is_wave_active') ?? false;
  }

  Future<void> _setWaveStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateTime.now().toString().split(' ')[0];

    await prefs.setBool('is_wave_active', value);
    await prefs.setString('last_wave_date', today);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.goNamed(
            AppPages.profileFriendName,
            pathParameters: {'uid': uid},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageUrl != null && imageUrl != 'false'
                        ? Image.network(
                            '$baseUrl$imageUrl',
                            width: 64.0,
                            height: 64.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                SvgPicture.asset(
                              AppImages.avatarDefaultIcon,
                              width: 64.0,
                            ),
                          )
                        : SvgPicture.asset(
                            AppImages.avatarDefaultIcon,
                            width: 64.0,
                          ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? 'User',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          if (lastLogin != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'อัพเดท:',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  ThaiDateFormatter.formatSingleDate(
                                    DateTime.parse(lastLogin!),
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    _buildWaveIcon(context),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'ก้าวเดิน',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.darkGrayColor,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$steps ก้าว',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.grey[300],
                    ),
                    Column(
                      children: [
                        Text(
                          'การนอน',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.darkGrayColor,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$sleepHours ชม.',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
