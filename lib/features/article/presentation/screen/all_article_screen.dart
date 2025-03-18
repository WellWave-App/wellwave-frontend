import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/theme/app_theme.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
import 'package:wellwave_frontend/features/article/presentation/widget/recommendation_card.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diseaseIds =
        GoRouterState.of(context).uri.queryParameters['diseaseIds'];
    print('🔍 ohh diseaseIds from queryParams: $diseaseIds');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ArticleBloc>()
          .add(FetchArticlesEvent(diseaseIds: diseaseIds));
    });

    final Map<String, String> diseaseTitles = {
      '2': 'ความดันโลหิตสูง',
      '1': 'โรคเบาหวาน',
      '4': 'โรคอ้วน',
      '3': 'ไขมันในเลือดสูง',
    };

    final String appBarTitle = diseaseTitles[diseaseIds] ?? 'บทความทั้งหมด';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
        iconTheme: IconThemeData(
          color: Colors.black, // 🔥 เปลี่ยนเป็นสีแดง (เปลี่ยนเป็นสีที่ต้องการ)
        ),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            if (state.articles.isEmpty) {
              return Center(child: Text('ไม่มีบทความที่แสดงในขณะนี้'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // จำนวนคอลัมน์
                  crossAxisSpacing: 5, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 4, // ระยะห่างระหว่างแถว
                ),
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return RecommendationCard(
                    title: article.topic,
                    readingTime: article.estimatedReadTime,
                    imageUrl: article.thumbnailUrl,
                    article: article,
                  );
                },
              ),
            );
          } else if (state is ArticleError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('ไม่มีบทความที่แสดงในขณะนี้'));
          }
        },
      ),
    );
  }
}
