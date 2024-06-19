class BaseApiResponse {
  bool isSuccess;
  String message;
  BaseApiResponse({
    required this.isSuccess,
    this.message = '',
  });

  BaseApiResponse.success({
    this.isSuccess = true,
    this.message = '',
  });
  BaseApiResponse.failure({
    this.isSuccess = false,
    this.message = '',
  });
}
