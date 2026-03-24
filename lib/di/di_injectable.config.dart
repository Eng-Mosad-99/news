// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api/api_manager.dart' as _i1047;
import '../data/repository/news/data_source/remote/impl/news_remote_data_source_impl.dart'
    as _i552;
import '../data/repository/news/data_source/remote/news_remote_data_source.dart'
    as _i319;
import '../data/repository/news/repo/impl/news_repo_impl.dart' as _i740;
import '../data/repository/news/repo/news_repo.dart' as _i236;
import '../data/repository/sources/data_source/local/impl/source_local_data_source_impl.dart'
    as _i637;
import '../data/repository/sources/data_source/local/source_local_data_source.dart'
    as _i197;
import '../data/repository/sources/data_source/remote/impl/source_remote_data_source_impl.dart'
    as _i371;
import '../data/repository/sources/data_source/remote/source_remote_data_source.dart'
    as _i854;
import '../data/repository/sources/repo/impl/source_repo_impl.dart' as _i353;
import '../data/repository/sources/repo/source_repository.dart' as _i548;
import '../home/category_details/cubit/category_cubit.dart' as _i36;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i197.SourceLocalDataSource>(
        () => _i637.SourceLocalDataSourceImpl());
    gh.factory<_i854.SourceRemoteDataSource>(() =>
        _i371.SourceRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i319.NewsRemoteDataSource>(() =>
        _i552.NewsRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i236.NewsRepository>(() => _i740.NewsRepoImpl(
        newsRemoteDataSource: gh<_i319.NewsRemoteDataSource>()));
    gh.factory<_i548.SourceRepository>(() => _i353.SourceRepoImpl(
          sourceRemoteDataSource: gh<_i854.SourceRemoteDataSource>(),
          sourceLocalDataSource: gh<_i197.SourceLocalDataSource>(),
        ));
    gh.factory<_i36.CategoryCubit>(() =>
        _i36.CategoryCubit(sourceRepository: gh<_i548.SourceRepository>()));
    return this;
  }
}
