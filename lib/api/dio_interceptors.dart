import 'package:dio/dio.dart';
import 'package:news/api/app_exception.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String message = 'Something went wrong , please try again later';
    try {
      if (err.response != null &&
          err.response!.data is Map &&
          err.response!.data.containsKey('message')) {
        message = err.response!.data['message'];
      } else {
        //! TODO: fallback message or other bad response types
        switch (err.type) {
          case DioErrorType.connectionTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.connectionError:
            message =
                'Connection timeout, please check your internet connection';
            break;
          case DioErrorType.cancel:
            message = 'Request was canceled.';
            break;
          case DioErrorType.badResponse:
            message =
                'Failed to load data. status code : ${err.response?.statusCode}';
            break;

          case DioErrorType.unknown:
            message = 'An unknown network error occurred';
            break;

          default:
            message = 'An unknown error occurred';
            break;
        }
      }
    } catch (e) {
      message = 'An unexpected error occurred ==> ${e.toString()}';
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        error: AppException(message: message),
        response: err.response,
      ),
    );
  }
}
