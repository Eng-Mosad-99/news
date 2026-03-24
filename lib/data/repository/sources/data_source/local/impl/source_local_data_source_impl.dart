import 'package:hive/hive.dart';
import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/model/source_response.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  void cacheSources({required SourceResponse sourceResponse , required String categoryId}) async {
    // TODO: implement cacheSources.
    var box = await Hive.openBox('sources');
    //! Object ==> Map
    box.put(categoryId, sourceResponse);
    // box.put(categoryId, sourceResponse.toJson());
    await box.close();
  }

  @override
  Future<SourceResponse> getSources({required String categoryId}) async{
    // TODO: implement getSources.
    var box =await Hive.openBox('sources');
    //! Map ==> Object
   var data = box.get(categoryId);
  //  var data = SourceResponse.fromJson(box.get(categoryId));
    return data;
  }
}
