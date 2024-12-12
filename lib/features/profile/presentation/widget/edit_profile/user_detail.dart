import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:wellwave_frontend/features/profile/presentation/bloc/profile_state.dart';

import '../../../../logs/presentation/widget/scale_record_widget.dart';

class UserDetailCard extends StatefulWidget {
  const UserDetailCard({super.key});

  @override
  State<UserDetailCard> createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard> {
  String userName = '';
  String gender = 'หญิง';
  int birthYear = 2545;
  num height = 155.0;
  num weight = 50.5;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(FetchUserProfile(3)); // Fetch user with uid 3
  }

  final RulerPickerController heightController =
      RulerPickerController(value: 155);
  final RulerPickerController weightController =
      RulerPickerController(value: 50.5);
  final List<String> _genderList = <String>[
    'ชาย',
    'หญิง',
  ];
  final List<int> yearList = List.generate(
    DateTime.now().year - 1900 + 1,
    (index) => 1900 + index,
  );

  Widget _buildScaleRecord(
    String title,
    String label,
    RulerPickerController controller,
    Function(num) onValueChanged,
  ) {
    return ScaleRecordWidget(
      title: title,
      titleStyle: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold),
      titleAlign: MainAxisAlignment.center,
      label: label,
      initialValue: controller.value,
      controller: controller,
      onValueChanged: onValueChanged,
    );
  }

  Widget _buildConfirmButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: _submitLogs,
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          child: Text(AppStrings.confirmText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildCancleButton() {
    return Expanded(
      child: SizedBox(
        width: 170,
        height: 60,
        child: TextButton(
          onPressed: () => setState(() => Navigator.pop(context)),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: AppColors.primaryColor, width: 1),
              ),
            ),
          ),
          child: Text(AppStrings.backText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryColor)),
        ),
      ),
    );
  }

  void _submitLogs() {
    final imageUrl = "https://example.com/image.jpg"; // Replace with the actual image URL or leave as is
    
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    profileBloc.add(EditUserProfile(
      uid: 3, // Update the user ID here
      imageUrl: imageUrl,
      username: userName,
      yearOfBirth: birthYear,
      gender: gender == 'หญิง' ? false : true, 
      height: height,
      weight: weight,
    ));

    Navigator.pop(context);
  }

 @override
Widget build(BuildContext context) {
  return BlocListener<ProfileBloc, ProfileState>(
    listener: (context, state) {
      if (state is ProfileLoaded) {
        setState(() {
          userName = state.userProfile.username;  
          gender = state.userProfile.gender ? 'ชาย' : 'หญิง'; 
          birthYear = state.userProfile.yearOfBirth;
          height = state.userProfile.height;  
          weight = state.userProfile.weight;  
        });
      }
    },
    child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              // Username Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(AppStrings.userNameText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      Text(userName,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFDFDFDF)),
              const SizedBox(height: 12),

              // Gender Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(AppStrings.genderText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      Text(gender,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await showModalBottomSheet<int>(
                          backgroundColor: AppColors.whiteColor,
                          context: context,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 40),
                                    Text(AppStrings.genderText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: CupertinoPicker(
                                        backgroundColor: AppColors.whiteColor,
                                        itemExtent: 40,
                                        onSelectedItemChanged: (int index) {
                                          gender = _genderList[index];
                                        },
                                        children: _genderList
                                            .map((gender) => Center(
                                                  child: Text(
                                                    gender,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCancleButton(),
                                          const SizedBox(width: 10),
                                          _buildConfirmButton()
                                        ])
                                  ],
                                ),
                              ));
                      if (result != null) {
                        setState(() {
                          gender = result as String;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFDFDFDF)),
              const SizedBox(height: 12),

              // Birth Year Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(AppStrings.birthYearText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      Text(birthYear.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await showModalBottomSheet<int>(
                          backgroundColor: AppColors.whiteColor,
                          context: context,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(AppStrings.birthYearText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: CupertinoPicker(
                                        backgroundColor: AppColors.whiteColor,
                                        itemExtent: 40,
                                        scrollController: FixedExtentScrollController(
                                          initialItem: DateTime.now().year - 1900, // Default year
                                        ),
                                        onSelectedItemChanged: (int index) {
                                          birthYear = yearList[index];
                                        },
                                        children: yearList
                                            .map((year) => Center(
                                                  child: Text(
                                                    year.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCancleButton(),
                                          const SizedBox(width: 10),
                                          _buildConfirmButton()
                                        ])
                                  ],
                                ),
                              ));
                      if (result != null) {
                        setState(() {
                          birthYear = result;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFDFDFDF)),
              const SizedBox(height: 12),

              // Weight Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(AppStrings.weightText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      Text('$weight ${AppStrings.kgText}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await showModalBottomSheet<int>(
                          backgroundColor: AppColors.whiteColor,
                          context: context,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 24),
                                    _buildScaleRecord(
                                        AppStrings.weightText,
                                        AppStrings.kgText,
                                        weightController,
                                        (value) => height = value),
                                    const SizedBox(height: 24),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCancleButton(),
                                          const SizedBox(width: 10),
                                          _buildConfirmButton()
                                        ])
                                  ],
                                ),
                              ));
                      if (result != null) {
                        setState(() {
                          weight = result;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFDFDFDF)),
              const SizedBox(height: 12),

              // Height Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(AppStrings.heightText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      Text('$height ${AppStrings.cmText}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith())
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      int? result = await showModalBottomSheet<int>(
                          backgroundColor: AppColors.whiteColor,
                          context: context,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 8),
                                    ),
                                    const SizedBox(height: 24),
                                    _buildScaleRecord(
                                        AppStrings.heightText,
                                        AppStrings.cmText,
                                        heightController,
                                        (value) => height = value),
                                    const SizedBox(height: 24),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCancleButton(),
                                          const SizedBox(width: 10),
                                          _buildConfirmButton()
                                        ])
                                  ],
                                ),
                              ));
                      if (result != null) {
                        setState(() {
                          height = result;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
}
