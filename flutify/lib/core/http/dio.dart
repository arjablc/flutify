import "package:dio/dio.dart";


class HttpService {
  late Dio _dio;
  //TODO: to make the connectivityService injected

  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: Headers.jsonContentType,
  );



  Dio getDio () {
    _dio = Dio(_baseOptions);
    return _dio;
  }


}
