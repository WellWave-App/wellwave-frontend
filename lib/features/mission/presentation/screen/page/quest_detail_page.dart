import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwave_frontend/common/widget/app_bar.dart';
import 'package:wellwave_frontend/common/widget/button_widget.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class QuestDetailPage extends StatelessWidget {
  const QuestDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath = AppImages.emptyComponentImage;
    String questTitle = 'ทำกิจกรรม 15 นาที 3 กิจกรรม ใน 1 อาทิตย์ ';
    String iconPath = AppImages.gemIcon;
    String questLabel = '5 วัน';
    int amountOfReward = 15;
    String detailLabel =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consecteturLorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, ';

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.whiteColor,
        onLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      imagePath,
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questTitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(),
                          softWrap:
                              true, // Allows the text to wrap to the next line
                          maxLines:
                              3, // Limits the number of lines (adjust as needed)
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.gemIcon),
                            const SizedBox(width: 12),
                            Text(
                              questLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'รางวัลที่จะได้รับ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Image.asset(
                            iconPath,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '   x$amountOfReward',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'รายละเอียด',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        detailLabel,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                    ],
                  )),
            ),
            const NextButton(text: AppStrings.joinProgram)
          ],
        ),
      ),
    );
  }
}
