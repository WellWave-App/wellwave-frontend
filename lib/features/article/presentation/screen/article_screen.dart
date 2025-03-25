// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wellwave_frontend/config/constants/app_colors.dart';
// import 'package:wellwave_frontend/config/constants/app_images.dart';
// import 'package:wellwave_frontend/config/constants/app_pages.dart';
// import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
// import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
// import 'package:wellwave_frontend/features/article/presentation/widget/recommendation_card.dart';
// import '../widget/disease_card.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ArticleScreen extends StatefulWidget {
//   const ArticleScreen({super.key});

//   @override
//   _ArticleScreenState createState() => _ArticleScreenState();
// }

// class _ArticleScreenState extends State<ArticleScreen> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // โหลดข้อมูลเมื่อเข้าหน้านี้ทุกครั้ง
//     context.read<ArticleBloc>().add(FetchRecommendArticleEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   context.read<ArticleBloc>().add(FetchRecommendArticleEvent());
//     // });

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
//                       child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'ค้นหาบทความ',
//                       hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.grey, width: 1.0),
//                       ),
//                       filled: true,
//                       fillColor: AppColors.whiteColor,
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                     ),
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                     onSubmitted: (searchQuery) {
//                       // เรียกใช้การค้นหาเมื่อกด Enter
//                       context
//                           .read<ArticleBloc>()
//                           .add(SearchArticleEvent(query: searchQuery));
//                     },
//                   )),
//                   SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate using GoRouter
//                       context.pushNamed(
//                         AppPages.allArticleName,
//                         queryParameters: {'diseaseIds': '0'},
//                       ).then((_) {
//                         if (context.mounted) {
//                           context
//                               .read<ArticleBloc>()
//                               .add(FetchRecommendArticleEvent());
//                         }
//                       });
//                     },
//                     child: SvgPicture.asset(AppImages.bookmarkIcon),
//                   )
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
//                       children: [
//                         DiseaseCard(
//                           svgAsset: AppImages.bloodPressureIcon,
//                           title: 'โรค\nความดันโลหิตสูง',
//                           onTap: () {
//                             context.pushNamed(
//                               AppPages.allArticleName,
//                               queryParameters: {'diseaseIds': '2'},
//                             ).then((_) {
//                               if (context.mounted) {
//                                 context
//                                     .read<ArticleBloc>()
//                                     .add(FetchRecommendArticleEvent());
//                               }
//                             });
//                           },
//                         ),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                           svgAsset: AppImages.diabetesIcon,
//                           title: 'โรค\nเบาหวาน',
//                           onTap: () {
//                             context.pushNamed(
//                               AppPages.allArticleName,
//                               queryParameters: {'diseaseIds': '1'},
//                             ).then((_) {
//                               if (context.mounted) {
//                                 context
//                                     .read<ArticleBloc>()
//                                     .add(FetchRecommendArticleEvent());
//                               }
//                             });
//                           },
//                         ),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                           svgAsset: AppImages.obesityIcon,
//                           title: 'โรคอ้วน',
//                           onTap: () {
//                             context.pushNamed(
//                               AppPages.allArticleName,
//                               queryParameters: {'diseaseIds': '4'},
//                             ).then((_) {
//                               if (context.mounted) {
//                                 context
//                                     .read<ArticleBloc>()
//                                     .add(FetchRecommendArticleEvent());
//                               }
//                             });
//                           },
//                         ),
//                         SizedBox(width: 8),
//                         DiseaseCard(
//                           svgAsset: AppImages.hyperChoLesTeRoLeMiaIcon,
//                           title: 'โรคไขมัน\nในเลือดสูง',
//                           onTap: () {
//                             context.pushNamed(
//                               AppPages.allArticleName,
//                               queryParameters: {'diseaseIds': '3'},
//                             ).then((_) {
//                               if (context.mounted) {
//                                 context
//                                     .read<ArticleBloc>()
//                                     .add(FetchRecommendArticleEvent());
//                               }
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 36),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'แนะนำสำหรับคุณ',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: InkWell(
//                           onTap: () {
//                             context.pushNamed(
//                               AppPages.allArticleName,
//                               queryParameters: {'diseaseIds': '5'},
//                             ).then((_) {
//                               if (context.mounted) {
//                                 context
//                                     .read<ArticleBloc>()
//                                     .add(FetchRecommendArticleEvent());
//                               }
//                             });
//                           },
//                           child: Text(
//                             'ดูทั้งหมด',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // BlocBuilder to load the article grid
//                   BlocBuilder<ArticleBloc, ArticleState>(
//                       builder: (context, state) {
//                     print("Current State: $state"); // ตรวจสอบสถานะ

//                     if (state is ArticleInitial) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is ArticleRecommendLoaded) {
//                       if (state.articles.isEmpty) {
//                         // ถ้า articles เป็นค่าว่าง แสดงข้อความว่าไม่มีบทความ
//                         return Center(
//                           heightFactor: 15,
//                           child: Text('ไม่มีบทความที่แสดงในขณะนี้'),
//                         );
//                       } else {
//                         return GridView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2, // Number of columns
//                             crossAxisSpacing: 5, // Spacing between columns
//                             mainAxisSpacing: 4, // Spacing between rows
//                           ),
//                           itemCount: state.articles.length,
//                           itemBuilder: (context, index) {
//                             final article = state.articles[index];
//                             return RecommendationCard(
//                               title: article.topic,
//                               readingTime: article.estimatedReadTime,
//                               imageUrl: article.thumbnailUrl,
//                               article: article, // Pass the article object
//                               aid: article.aid, // Pass the required aid
//                             );
//                           },
//                         );
//                       }
//                     } else if (state is ArticleError) {
//                       return Center(
//                           child: Text('Error: ${state.errorMessage}'));
//                     } else {
//                       print('object');
//                       return Container(
//                         color: AppColors.blueGrayColor,
//                         child: Text('ไม่มีบทความที่แสดงในขณะนี้'),
//                       );
//                     }
//                   }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_images.dart';
import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_bloc.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
import 'package:wellwave_frontend/features/article/presentation/widget/recommendation_card.dart';
import '../widget/disease_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // โหลดข้อมูลเมื่อเข้าหน้านี้ทุกครั้ง
    context.read<ArticleBloc>().add(FetchRecommendArticleEvent());
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
      });
      context.read<ArticleBloc>().add(FetchRecommendArticleEvent());
    } else {
      setState(() {
        _isSearching = true;
      });
      context.read<ArticleBloc>().add(SearchArticleEvent(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'ค้นหาบทความ',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: _isSearching
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onSubmitted: (searchQuery) {
                      _performSearch(searchQuery);
                    },
                  )),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Navigate using GoRouter
                      context.pushNamed(
                        AppPages.allArticleName,
                        queryParameters: {'diseaseIds': '0'},
                      ).then((_) {
                        if (context.mounted) {
                          context
                              .read<ArticleBloc>()
                              .add(FetchRecommendArticleEvent());
                        }
                      });
                    },
                    child: SvgPicture.asset(AppImages.bookmarkIcon),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ซ่อนส่วน "ประเภทของโรค" เมื่อมีการค้นหา
                  if (!_isSearching) ...[
                    Text(
                      'ประเภทของโรค',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 148,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          DiseaseCard(
                            svgAsset: AppImages.bloodPressureIcon,
                            title: 'โรค\nความดันโลหิตสูง',
                            onTap: () {
                              context.pushNamed(
                                AppPages.allArticleName,
                                queryParameters: {'diseaseIds': '2'},
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<ArticleBloc>()
                                      .add(FetchRecommendArticleEvent());
                                }
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          DiseaseCard(
                            svgAsset: AppImages.diabetesIcon,
                            title: 'โรค\nเบาหวาน',
                            onTap: () {
                              context.pushNamed(
                                AppPages.allArticleName,
                                queryParameters: {'diseaseIds': '1'},
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<ArticleBloc>()
                                      .add(FetchRecommendArticleEvent());
                                }
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          DiseaseCard(
                            svgAsset: AppImages.obesityIcon,
                            title: 'โรคอ้วน',
                            onTap: () {
                              context.pushNamed(
                                AppPages.allArticleName,
                                queryParameters: {'diseaseIds': '4'},
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<ArticleBloc>()
                                      .add(FetchRecommendArticleEvent());
                                }
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          DiseaseCard(
                            svgAsset: AppImages.hyperChoLesTeRoLeMiaIcon,
                            title: 'โรคไขมัน\nในเลือดสูง',
                            onTap: () {
                              context.pushNamed(
                                AppPages.allArticleName,
                                queryParameters: {'diseaseIds': '3'},
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<ArticleBloc>()
                                      .add(FetchRecommendArticleEvent());
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36),
                    // ซ่อนส่วนหัวของ "แนะนำสำหรับคุณ" เมื่อมีการค้นหา
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'แนะนำสำหรับคุณ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(
                                AppPages.allArticleName,
                                queryParameters: {'diseaseIds': '5'},
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<ArticleBloc>()
                                      .add(FetchRecommendArticleEvent());
                                }
                              });
                            },
                            child: Text(
                              'ดูทั้งหมด',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  // แสดงชื่อหัวข้อสำหรับผลการค้นหา
                  if (_isSearching) ...[
                    Row(
                      children: [
                        Text(
                          'ผลการค้นหา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "' ${_searchController.text} '",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkerBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],

                  // BlocBuilder to load the article grid
                  BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                    print("Current State: $state"); // ตรวจสอบสถานะ

                    if (state is ArticleInitial) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ArticleRecommendLoaded ||
                        state is SearchArticleLoaded) {
                      final articles = state is ArticleRecommendLoaded
                          ? state.articles
                          : (state as SearchArticleLoaded).articles;

                      if (articles.isEmpty) {
                        // ถ้า articles เป็นค่าว่าง แสดงข้อความว่าไม่มีบทความ
                        return Center(
                          heightFactor: 8,
                          child: Text(
                            _isSearching
                                ? 'ไม่พบบทความที่คุณค้นหา'
                                : 'ไม่มีบทความที่แสดงในขณะนี้',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 5, // Spacing between columns
                            mainAxisSpacing: 4, // Spacing between rows
                          ),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return RecommendationCard(
                              title: article.topic,
                              readingTime: article.estimatedReadTime,
                              imageUrl: article.thumbnailUrl,
                              article: article, // Pass the article object
                              aid: article.aid, // Pass the required aid
                            );
                          },
                        );
                      }
                    } else if (state is ArticleError) {
                      return Center(
                          child: Text('Error: ${state.errorMessage}'));
                    } else {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.catNoItemimage, height: 128),
                          SizedBox(
                            height: 20,
                          ),
                          Text('ไม่มีบทความที่แสดงในขณะนี้'),
                        ],
                      ));
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
