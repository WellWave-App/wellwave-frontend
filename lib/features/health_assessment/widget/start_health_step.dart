import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/common/widget/custom_button.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/lib/features/health_assessment/presentation/health_assessment_page/health_assessment_page_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/screen/health_assessment_screen.dart';

class StartHealthStep extends StatelessWidget {
  const StartHealthStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                AppImages.healthassessmentImg,
                width: MediaQuery.of(context).size.width - 100,
              ),
              const SizedBox(
                height: 48,
              ),
              Text(
                "แบบประเมินสุขภาพ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "คัดกรองความเสี่ยงในกลุ่มภาวะโรคเมตาบอลิก (เบาหวาน ความดันโลหิตสูง ไขมัน และโรคอ้วน)",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
              ),
              CustomButton(
                width: 250,
                bgColor: AppColors.primaryColor,
                textColor: AppColors.backgroundColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AssessmentBloc(),
                        child: const AssessmentScreenView(),
                      ),
                    ),
                  );
                },
                title: 'เข้าสู่แบบประเมิน',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
