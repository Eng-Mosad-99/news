import 'package:news/model/source_response.dart';

abstract class SourceRepository {
  Future<SourceResponse> getSources({required String categoryId});
}