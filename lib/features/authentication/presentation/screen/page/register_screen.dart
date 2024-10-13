import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class RegisterScreen extends StatelessWidget {
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              AppImages.skyBgImage,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              AppImages.seaBgImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 104.0),
            child: Column(
              children: [
                Text(
                  AppStrings.registerText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
                  child: TextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                        labelText: 'อีเมล',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 7, bottom: 7),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isObscure,
                      builder: (context, isObscure, child) {
                        return TextField(
                          obscureText: isObscure,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            labelText: 'รหัสผ่าน',
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 14, bottom: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _isObscure.value =
                                    !_isObscure.value; // สลับสถานะ
                              },
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isObscure,
                      builder: (context, isObscure, child) {
                        return TextField(
                          obscureText: isObscure,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            labelText: 'ยืนยันรหัสผ่าน',
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 14, bottom: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _isObscure.value =
                                    !_isObscure.value; // สลับสถานะ
                              },
                            ),
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration
                  },
                  child: const Text('สมัครสมาชิก'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle Google registration
                  },
                  child: const Text('สมัครสมาชิกด้วย Google'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
