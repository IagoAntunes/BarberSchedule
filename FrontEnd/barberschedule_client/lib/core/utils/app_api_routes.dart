abstract class AppApiRoutes {
  static const String baseUrl = "https://localhost";

  static const String _authApiUrl = "https://10.0.2.2:7039/api/";

  static String registerClient() {
    return '${_authApiUrl}auth/register/client';
  }
}
