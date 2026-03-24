import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/model/source_response.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource{
  @override
  void cacheSources({required SourceResponse sourceResponse}) {
    // TODO: implement cacheSources
  }

  @override
  Future<SourceResponse> getSources({required String categoryId}) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
}