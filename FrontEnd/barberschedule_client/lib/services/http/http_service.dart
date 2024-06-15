import 'package:barberschedule_client/services/http/i_http_response.dart';
import 'package:barberschedule_client/services/http/i_http_service.dart';
import 'package:dio/dio.dart';

class HttpServiceImp implements IHttpService {
  late Dio _dio;
  HttpServiceImp() {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (statusCode) => true,
      contentType: Headers.jsonContentType,
    );

    _dio = Dio(options);
    // _dio.interceptors.addAll([
    //   HttpOptionsInterceptor(),
    //   AuthenticationInterceptor(secureStorage: _storage)
    // ]);
  }
  Future<HttpResponse<T>?> _executeRequest<T>(
    Future<Response> Function() executionFunction, {
    Duration? timeOut,
  }) async {
    try {
      Response response = await executionFunction()
          .timeout(timeOut ?? const Duration(seconds: 30));

      return _dioResponseConverter(response);
    } on DioException {
      return null;
    }
  }

  @override
  Future<HttpResponse<T>?> get<T>(String url,
      {Map<String, dynamic>? queryParameters, Duration? timeOut}) async {
    return _executeRequest(
        () => _dio.get(url, queryParameters: queryParameters),
        timeOut: timeOut);
  }

  @override
  Future<HttpResponse<T>?> post<T>(
    String url,
    data, {
    Map<String, dynamic>? queryParameters,
    Duration? timeOut,
  }) async {
    return _executeRequest(
        () => _dio.post(url, data: data, queryParameters: queryParameters),
        timeOut: timeOut);
  }

  @override
  Future<HttpResponse<T>?> patch<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.patch(url, data: data, queryParameters: queryParameters));
  }

  @override
  Future<HttpResponse<T>?> put<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.put(url, data: data, queryParameters: queryParameters));
  }

  @override
  Future<HttpResponse<T>?> delete<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.delete(url, data: data, queryParameters: queryParameters));
  }

  //Response Utils

  HttpResponse<T> _dioResponseConverter<T>(Response? response) {
    return HttpResponse<T>(
      statusCode: response?.statusCode,
      data: response?.data,
      headers: response?.headers.map,
    );
  }
}
