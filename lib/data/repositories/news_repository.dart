import '../datasources/gemini_summary_data_source.dart';
import '../datasources/news_remote_data_source.dart';
import '../models/news_brief.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final GeminiSummaryDataSource geminiSummaryDataSource;

  NewsRepository({
    required this.remoteDataSource,
    required this.geminiSummaryDataSource,
  });

  Future<NewsBrief> getTechNewsBrief() async {
    final news = await remoteDataSource.fetchNews();
    final curatedSummary =
        await geminiSummaryDataSource.fetchCuratedSummary(news);

    return NewsBrief(news: news, curatedSummary: curatedSummary);
  }
}


