import 'package:wellwave_frontend/features/article/data/models/article_bookmark.dart';

import '../../data/models/article_model.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<ArticleModel> articles;

  ArticleLoaded(this.articles);
}

class ArticleBookmarkLoading extends ArticleState {}

class ArticleBookmarkLoaded extends ArticleState {
  final List<BookmarkModel> articlesBookmark;

  ArticleBookmarkLoaded(this.articlesBookmark);
}

class ArticleError extends ArticleState {
  final String errorMessage;

  ArticleError(this.errorMessage);
}
