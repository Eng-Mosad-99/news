import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';

class ApiManager {
  // https://newsapi.org/v2/top-headlines/sources?
  static void getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
    });
    http.get(url);
  }
}
