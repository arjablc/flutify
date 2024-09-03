import 'package:http/http.dart' as http;

class ConnectivityService {
  static const googleUrl = 'http://www.google.com';

  Future<bool> checkConnection() async {
    try {
      await http.get(Uri.parse(googleUrl));
      return true;
    } catch (e) {
      return false;
    }
  }
}
