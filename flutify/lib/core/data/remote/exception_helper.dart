import 'package:dio/dio.dart' show DioExceptionType, DioException;

import '../../failure/failure.dart';

class ExceptionHelper {
  static AppFailure dioExceptionToFailure(DioException exception) {
    late String message;
    StackTrace? trace;

    switch (exception.type) {
      case DioExceptionType.sendTimeout:
        message = 'Request Send Timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response receive Timeout';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection Error';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection Timed out';
        break;
      case DioExceptionType.badResponse:
        return ServerFailure.fromJson(exception.response!.data);
      default:
        message = 'Something went horribly worng';
    }

    return ServerFailure(message: message, trace: trace);
  }
}
