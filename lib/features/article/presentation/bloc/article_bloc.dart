// article_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wellwave_frontend/features/article/presentation/bloc/article_state.dart';
import '../../data/models/article_model.dart';
import '../../data/repositories/article_repository.dart';

part 'article_event.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  // Constructor
  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    on<FetchArticlesEvent>((event, emit) async {
      emit(ArticleLoading()); // กำลังโหลดข้อมูล

      try {
        final articles = await articleRepository.fetchArticles();
        emit(ArticleLoaded(articles)); // ส่งข้อมูลเมื่อโหลดสำเร็จ
      } catch (e) {
        emit(ArticleError("ไม่สามารถโหลดข้อมูลได้: ${e.toString()}"));
      }
    });
  }
}
