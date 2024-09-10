import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';

class StartHealthStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              "คัดกรองความเสี่ยงในกลุ่มภาวะโรคเมตาบอลิก \n(เบาหวาน ความดันโลหิตสูง ไขมัน และโรคอ้วน)",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
