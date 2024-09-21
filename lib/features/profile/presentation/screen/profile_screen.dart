import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userID = '503450293';
    int league = 0;
    int gemAmount = 20;
    int expAmount = 34;

    List<String> leagueList = [
      AppStrings.bronzeLeaugeText,
      AppStrings.silverLeaugeText,
      AppStrings.goldLeaugeText,
      AppStrings.diamondLeaugeText,
      AppStrings.emeraldLeaugeText,
    ];

    return Scaffold(
      appBar: CustomAppBar(title: '', context: context, onLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                radius: 64,
                backgroundImage:
                    NetworkImage('https://example.com/profile-pic.jpg'),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.userNameText,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${AppStrings.idText}: $userID',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppImages.copyIcon)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F0FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppImages.articleIcon,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppStrings.leagueText} ${leagueList[league]}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F0FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppImages.articleIcon,
                            height: 47,
                            width: 47,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                '$gemAmount',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                AppStrings.gemText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(width: 16),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F0FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppImages.articleIcon,
                            height: 47,
                            width: 47,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                '$expAmount',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                AppStrings.expText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(height: 24),
              const Divider(color: Colors.black),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Posts', '255'),
                  _buildStatColumn('Followers', '12.8k'),
                  _buildStatColumn('Following', '420'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement edit profile action
                },
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
              _buildInfoCard('Email', 'johndoe@example.com'),
              _buildInfoCard('Phone', '+1 234 567 890'),
              _buildInfoCard('Location', 'New York, USA'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        leading: Icon(
          title == 'Email'
              ? Icons.email
              : title == 'Phone'
                  ? Icons.phone
                  : Icons.location_on,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.healthHistoryText,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.whiteColor,
          ),
    );
  }
}
