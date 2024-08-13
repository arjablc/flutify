import "package:dio/dio.dart";

class HttpProvider {
  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: Headers.jsonContentType,
  );

  Dio _dio = Dio(_baseOptions);
}
