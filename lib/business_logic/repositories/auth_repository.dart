import 'package:greeny_flutter_app/connection.dart';

class AuthRepository {
  Future<dynamic> login(String email, String password) async {
    try {
      var url = "${conn.getUrl()}/api/login";
      var response = await httpClient.post(Uri.parse(url), body: {
        'email': email.trim(),
        'password': password.trim(),
      });

      if (response.statusCode > 210) throw Exception("Error logging in!");

      return response.body;
    } on Exception {
      rethrow;
    }
  }

  Future<String> register(String username, String email, String password,
      String passwordConfirmation) async {
    var url = "${conn.getUrl()}/api/register";

    var response = await httpClient.post(Uri.parse(url), body: {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'password_confirmation': password.trim()
    });

    if (response.statusCode != 201) {
      throw Exception("Error registering, please try again.");
    }
    return response.body;
  }
}
