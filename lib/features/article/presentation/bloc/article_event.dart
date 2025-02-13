part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}

class FetchArticlesEvent extends ArticleEvent {} // Event สำหรับดึงบทความ
