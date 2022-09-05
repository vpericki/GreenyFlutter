import 'package:greeny_flutter_app/business_logic/secure_storage.dart';
import 'package:http/http.dart' as http;

class Connection {
  var url = '';

  String getUrl() {
    url = 'https://greeny-dev.herokuapp.com/public';

    return url;
  }

  Future<Map<String, String>> getAuthorizationHeaders() async {
    var token = await secureStorage.getToken();
    return {'Authorization': 'Bearer ${token!}'};
  }
}

var conn = Connection();
var httpClient = http.Client();
