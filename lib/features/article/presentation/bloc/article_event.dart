part of 'article_bloc.dart';

abstract class ArticleEvent {}

class FetchArticlesEvent extends ArticleEvent {
  final String? diseaseIds;
  
  FetchArticlesEvent({this.diseaseIds, String? diseaseId});
}

class FetchArticlesBookmarkEvent extends ArticleEvent {
  final String userId;

  FetchArticlesBookmarkEvent({required this.userId});

}