class BaseApiResponse {
  bool isSuccess;
  String message;
  BaseApiResponse._({
    required this.isSuccess,
    required this.message,
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
