import 'dart:convert';
import 'dart:io';

class AppFailure {
  final String message;
  final StackTrace? trace;
  final List<String>? detail;

  const AppFailure({this.detail, required this.message, this.trace});

  factory AppFailure.fromJson(String source) {
    return AppFailure.fromMap(jsonDecode(source));
  }

  factory AppFailure.fromMap(Map<String, dynamic> source) {
    final details = source['detail'] as List<dynamic>?;
    print(details.toString());

    final listOfDetails = details!.map((e) {
      return "${e['path']}:${e['message']}";
    }).toList();
    print(listOfDetails);

    return AppFailure(
        message: source['message'], detail: ['somethign', 'something else']);
  }
}

void main() async {
  File inFile = File('dummy_error.json');
  final source = await inFile.readAsString(encoding: utf8);
  AppFailure failure = AppFailure.fromJson(source);
  print(failure.toString());
}
