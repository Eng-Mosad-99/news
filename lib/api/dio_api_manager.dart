import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiManager {
 final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org',
      queryParameters: {'apiKey': ApiConstants.apiKey},
    ),
    
  );

  DioApiManager() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args){
            // don't print requests with uris containing '/posts' 
            if(options.path.contains('/posts')){
              return false;
            }
            // don't print responses with unit8 list data
            return !args.isResponse || !args.hasUint8ListData;
          }
      )
    );
  }
  

  Future<SourceResponse> getSources({required String categoryId}) async {
    try {
      var response = await _dio.get(
        EndPoints.sourceApi,
        queryParameters: {'category': categoryId},
      );

      var json = response.data;
      return SourceResponse.fromJson(json);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<NewsResponse> getNewsBySourceId(String sourceId) async {
    try {
      var response = await _dio.get(
        EndPoints.newsApi,
        queryParameters: {'sources': sourceId},
      );

      var json = response.data;
      return NewsResponse.fromJson(json);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
