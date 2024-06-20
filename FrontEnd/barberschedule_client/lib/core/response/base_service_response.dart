abstract class ResponseDataObject {}

class SuccessResponseData extends ResponseDataObject {
  final Map<String, dynamic> data;
  SuccessResponseData._({
    required this.data,
  });
}

class ErrorResponseData extends ResponseDataObject {
  final Map<String, dynamic> data;
  ErrorResponseData._({
    required this.data,
  });
}

class ResponseData {
  ResponseData._();

  static SuccessResponseData success(responseData) {
    var result = responseData;
    if (responseData is! Map<String, dynamic>) {
      if (responseData is List<dynamic>) {
        result = {
          'data': responseData,
        };
      } else {}
    }
    return SuccessResponseData._(
        data: result is! Map<String, dynamic> ? {} : result);
  }

  static ErrorResponseData error(dynamic responseData) {
    responseData ??= {"message": "Ocorreu um problema"};
    return ErrorResponseData._(data: responseData);
  }
}
