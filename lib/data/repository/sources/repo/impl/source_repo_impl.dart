import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repo/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceRepoImpl implements SourceRepository {
  final SourceRemoteDataSource sourceRemoteDataSource;
  SourceRepoImpl({required this.sourceRemoteDataSource});
  @override
  Future<SourceResponse> getSources({required String categoryId}) {
    return sourceRemoteDataSource.getSources(categoryId: categoryId);
  }
}
