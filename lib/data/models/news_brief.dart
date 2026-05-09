import 'news_item.dart';

class NewsBrief {
  final List<NewsItem> news;
  final String curatedSummary;

  const NewsBrief({required this.news, required this.curatedSummary});
}