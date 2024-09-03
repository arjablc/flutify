import 'package:equatable/equatable.dart';

class AppFailure extends Equatable {
  final String message;
  const AppFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends AppFailure {
  final StackTrace? trace;
  final List<String>? details;

  const ServerFailure({this.details, this.trace, required super.message});

  @override
  List<Object?> get props => [
        message,
      ];
  @override
  String toString() {
    return 'message: $message ';
  }

  // must be already json decoded
  factory ServerFailure.fromJson(Map<String, dynamic> source) {
    final details = source['detail'] as List<dynamic>;
    // check for detail and the type of detail
    if (details.runtimeType == List) {
      final listOfDetails = details
          .map(
            (e) => "${e['path']} ${e['message']}",
          )
          .toList();

      return ServerFailure(
        message: source['message'],
        details: listOfDetails,
      );
    }
    return ServerFailure(
      message: source['message'],
    );
  }
}
