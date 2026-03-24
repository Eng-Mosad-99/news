import 'package:injectable/injectable.dart';
import 'package:news/data/repository/news/data_source/remote/news_remote_data_source.dart';
import 'package:news/data/repository/news/repo/news_repo.dart';
import 'package:news/model/news_response.dart';
@Injectable(as: NewsRepository)
class NewsRepoImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  NewsRepoImpl({required this.newsRemoteDataSource});
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId) {
    return newsRemoteDataSource.getNewsBySourceId(sourceId);
  }
}