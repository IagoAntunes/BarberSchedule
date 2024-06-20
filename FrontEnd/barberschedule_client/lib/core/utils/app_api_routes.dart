abstract class AppApiRoutes {
  static const String baseUrl = "https://localhost";

  static const String _authApiUrl = "https://10.0.2.2:7039/api/";
  static const String _ordersApiUrl = "https://10.0.2.2:7199/api/";

  static String registerClient() {
    return '${_authApiUrl}auth/register/client';
  }

  static String loginClient() {
    return '${_authApiUrl}auth/login/client';
  }

  static String getOrdersByUserId() {
    return '${_ordersApiUrl}Orders/GetByUserId';
  }

  static String getNextOrder() {
    return '${_ordersApiUrl}Orders/GetCurrentOrder';
  }
}
