import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/news/repo/impl/news_repo_impl.dart';
import 'package:news/data/repository/news/repo/news_repo.dart';
import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/repo/impl/source_repo_impl.dart';
import 'package:news/data/repository/sources/repo/source_repository.dart';
import '../data/repository/news/data_source/remote/impl/news_remote_data_source_impl.dart';
import '../data/repository/news/data_source/remote/news_remote_data_source.dart';
import '../data/repository/sources/data_source/local/impl/source_local_data_source_impl.dart';
import '../data/repository/sources/data_source/remote/impl/source_remote_data_source_impl.dart';
import '../data/repository/sources/data_source/remote/source_remote_data_source.dart';

//! For Sources
SourceRepository injectSourceRepository() {
  return SourceRepoImpl(
    sourceRemoteDataSource: injectSourceRemoteDataSource(),
    sourceLocalDataSource: injectSourceLocalDataSource(),
  );
}

SourceRemoteDataSource injectSourceRemoteDataSource() {
  return SourceRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

SourceLocalDataSource injectSourceLocalDataSource() {
  return SourceLocalDataSourceImpl();
}

//! For News
NewsRepository injectNewsRepository() {
  return NewsRepoImpl(newsRemoteDataSource: injectNewsRemoteDataSource());
}

NewsRemoteDataSource injectNewsRemoteDataSource() {
  return NewsRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
