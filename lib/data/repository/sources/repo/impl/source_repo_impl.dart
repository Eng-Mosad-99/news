import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repo/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceRepoImpl implements SourceRepository {
  final SourceRemoteDataSource sourceRemoteDataSource;
  final SourceLocalDataSource sourceLocalDataSource;
  SourceRepoImpl({required this.sourceRemoteDataSource , required this.sourceLocalDataSource});
  @override
  Future<SourceResponse> getSources({required String categoryId}) {
    //! TODO: internet ==> remote data source
    //! no internet ==> local data source
    return sourceRemoteDataSource.getSources(categoryId: categoryId);
  }
}
