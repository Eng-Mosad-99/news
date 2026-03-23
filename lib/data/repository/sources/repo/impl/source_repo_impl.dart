import 'package:news/data/repository/sources/repo/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceRepoImpl implements SourceRepository{
  @override
  Future<SourceResponse> getSources({required String categoryId}) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
}