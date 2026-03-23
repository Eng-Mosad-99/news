import 'package:news/model/source_response.dart';

abstract class SourceRemoteDataSource {
  Future<SourceResponse> getSources({required String categoryId});
}
