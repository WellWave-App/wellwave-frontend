part of 'article_bloc.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {} // สถานะเริ่มต้น

class ArticleLoading extends ArticleState {} // กำลังโหลดข้อมูล

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  ArticleLoaded(this.articles);
}

class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
