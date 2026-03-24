import '../../../../../model/source_response.dart';

abstract class SourceLocalDataSource {
  Future<SourceResponse> getSources({required String categoryId});

  void cacheSources({required SourceResponse sourceResponse , required String categoryId});
}
