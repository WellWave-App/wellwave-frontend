import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/features/article/presentation/widget/article_block.dart';

import '../widget/disease_card.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List articles = jsonMap['articles'];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ค้นหาบทความ',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        filled: true,
                        fillColor: AppColors.whiteColor,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(AppImages.bookmarkIcon),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ประเภทของโรค',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 148,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        DiseaseCard(
                            svgAsset: AppImages.bloodPressureIcon,
                            title: 'โรค\nความดันโลหิตสูง'),
                        SizedBox(width: 8),
                        DiseaseCard(
                            svgAsset: AppImages.diabetesIcon,
                            title: 'โรค\nเบาหวาน'),
                        SizedBox(width: 8),
                        DiseaseCard(
                            svgAsset: AppImages.obesityIcon, title: 'โรคอ้วน'),
                        SizedBox(width: 8),
                        DiseaseCard(
                            svgAsset: AppImages.hyperChoLesTeRoLeMiaIcon,
                            title: 'โรคไขมัน\nในเลือดสูง'),
                      ],
                    ),
                  ),
                  SizedBox(height: 36),
                  Text(
                    'แนะนำสำหรับคุณ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      
                      
                    ),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      var article = articles[index];
                      return RecommendationCard(
                        title: article['title'],
                        readingTime: article['readingTime'],
                        imageUrl: article['imageUrl'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
