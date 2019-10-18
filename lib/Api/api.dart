import 'dart:io';

import 'package:http/http.dart';

class Api {
  // AUTH
  static const String _registerToken =
      'Token	ad63d5e0fcee5f235174c439f20f523fe5693628';

  static String _authToken = '';

  static setAuthToken(String token) => _authToken = token;

  // URLS
  static const String _link = 'https://api.knctu.com/api/';

  static const String _userView = '${_link}user/';

  static String _userDetail(String id) => '$_userView$id';

  static const String _tokenView = '${_link}token/';

  // General
  static Future<Response> ping() {
    return get(_link);
  }

  // User App
  static Future<Response> createUser(
      String id, String name, String email, String password) {
    return post(_userView,
        body: {'id': id, 'name': name, 'email': email, 'password': password},
        headers: {HttpHeaders.authorizationHeader: _registerToken});
  }

  static Future<Response> getToken(String email, String password) {
    return post(_tokenView, body: {'email': email, 'password': password});
  }
}

class Connect {
  static bool _isConnected;

  static bool get getConnection => _isConnected;

  static Future<bool> isConnected() async {
    _isConnected = (await Api.ping()).statusCode == 200;
    return _isConnected;
  }
}
