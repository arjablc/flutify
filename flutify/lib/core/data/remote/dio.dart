import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@riverpod
HttpService httpServce(HttpServceRef ref) {
  return HttpService();
}

class HttpService {
  late Dio _dio;

  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: Headers.jsonContentType,
  );

  Dio getDio() {
    _dio = Dio(_baseOptions);
    return _dio;
  }
}
