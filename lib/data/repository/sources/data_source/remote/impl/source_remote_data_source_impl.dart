import 'package:news/api/api_manager.dart';
import 'package:news/model/source_response.dart';

import '../source_remote_data_source.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSource{
  final ApiManager apiManager;
  SourceRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<SourceResponse> getSources({required String categoryId}) async{
    var response=await apiManager.getSources(categoryId: categoryId);
    return response;
  }
}