import 'package:dio/dio.dart';

import '../failure/failure.dart';

class ExceptionHelper {
  static AppFailure dioExceptionToFailure(DioException exception) {
    late String message;
    StackTrace? trace;

    switch (exception.type) {
      case DioExceptionType.sendTimeout:
        message = "Request Send Timeout";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Response receive Timeout";
        break;
      case DioExceptionType.connectionError:
        message = "Connection Error";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection Timed out";
        break;
      case DioExceptionType.badResponse:
        final formattedResponse = exception.response!.data;
        message = formattedResponse['message'];

      default:
        message = "Something went horribly worng";
    }

    return AppFailure(message: message, trace: trace);
  }
}
