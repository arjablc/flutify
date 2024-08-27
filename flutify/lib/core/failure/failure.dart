class AppFailure {
  final String message;
  final List<Map<String, dynamic>>? detail;
  final StackTrace? trace;

  AppFailure({required this.message, this.detail, this.trace});
}
