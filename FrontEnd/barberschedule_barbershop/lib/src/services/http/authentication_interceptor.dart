import 'package:dio/dio.dart';

import '../database/key/shared_preferences_service.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(
      {required SharedPreferencesService sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService;
  final SharedPreferencesService _sharedPreferencesService;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _sharedPreferencesService.getData('token');
    if (!options.headers.containsKey('Authorization')) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (response.data is Map<String, dynamic>) {
      //
    }
  }
}
