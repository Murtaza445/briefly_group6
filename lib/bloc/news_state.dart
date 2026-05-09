import '../data/models/news_item.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsItem> news;
  final String curatedSummary;

  NewsLoaded({required this.news, required this.curatedSummary});
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}


