part of 'article_bloc.dart';

abstract class ArticleEvent {}

class FetchArticlesEvent extends ArticleEvent {
  final String? diseaseIds;
  
  FetchArticlesEvent({this.diseaseIds});
}
