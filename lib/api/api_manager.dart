import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  // https://newsapi.org/v2/top-headlines/sources?
  static Future<SourceResponse?> getSources() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
    });
  try {
    final response = await http.get(url);

String responseBody = response.body;  /// String
  /// String -> JSON -> Object
 var json = jsonDecode(responseBody); /// JSON
  return SourceResponse.fromJson(json); 
  } catch (e) {
    print(e);
    rethrow; 
  }
  }
}
