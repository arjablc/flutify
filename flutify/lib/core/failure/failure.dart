import 'package:equatable/equatable.dart';

class AppFailure extends Equatable {
  final String message;
  final StackTrace? trace;

  const AppFailure({required this.message, this.trace});

  @override
  List<Object?> get props => [
        message,
      ];
  @override
  String toString() {
    return "message: $message ";
  }
}
