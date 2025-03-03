// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wellwave_frontend/config/constants/app_colors.dart';
// import 'package:wellwave_frontend/config/constants/app_images.dart';
// import 'package:wellwave_frontend/config/constants/app_pages.dart';
// import 'package:wellwave_frontend/features/article/presentation/widget/article_block.dart';

// import '../widget/disease_card.dart';

// class ArticleScreen extends StatelessWidget {
//   const ArticleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> jsonMap = json.decode(jsonString);
//     List articles = jsonMap['articles'];
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 36),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'ค้นหาบทความ',
//                         hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               BorderSide(color: Colors.grey, width: 1.0),
//                         ),
//                         filled: true,
//                         fillColor: AppColors.whiteColor,
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                       ),
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   SvgPicture.asset(AppImages.bookmarkIcon),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ประเภทของโรค',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 24),
//                   SizedBox(
//                     height: 148,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: const [
//                         DiseaseCard(
//                             svgAsset: AppImages.bloodPressureIcon,
//                             title: 'โรค\nความดันโลหิตสูง'),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                             svgAsset: AppImages.diabetesIcon,
//                             title: 'โรค\nเบาหวาน'),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                             svgAsset: AppImages.obesityIcon, title: 'โรคอ้วน'),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                             svgAsset: AppImages.hyperChoLesTeRoLeMiaIcon,
//                             title: 'โรคไขมัน\nในเลือดสูง'),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 36),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           context.goNamed(AppPages.articleDetailName);
//                         },
//                         child: Text(
//                           'แนะนำสำหรับคุณ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: Text(
//                           'ดูทั้งหมด',
//                           style: TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                     itemCount: articles.length,
//                     itemBuilder: (context, index) {
//                       var article = articles[index];
//                       return RecommendationCard(
//                         title: article['title'],
//                         readingTime: article['readingTime'],
//                         imageUrl: article['imageUrl'],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
import '../bloc/article_state.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();

    // ใช้ WidgetsBinding.instance.addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ตอนนี้สามารถใช้ context ได้แล้ว
      context.read<ArticleBloc>().add(FetchArticlesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("บทความสุขภาพ")),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitial) {
            return Center(
                child:
                    CircularProgressIndicator()); // แสดง loading เมื่อเริ่มต้น
          } else if (state is ArticleLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12), // ✅ เพิ่มช่องว่างรอบๆ
                  decoration: BoxDecoration(
                    color: AppColors.gradientBlueColor,
                    borderRadius: BorderRadius.circular(10), // ✅ ทำมุมโค้ง
                    border: Border.all(
                        color: Colors.grey.shade300, width: 1), // ✅ ใส่เส้นขอบ
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ], // ✅ ใส่เงาให้ดูมีมิติ
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8), // ✅ เพิ่มระยะห่างใน ListTile
                    title: Text(
                      article.topic,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          } else if (state is ArticleError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
