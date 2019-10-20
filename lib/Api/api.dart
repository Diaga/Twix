import 'dart:io';

import 'package:http/http.dart';

class Api {
  // AUTH
  static const String _registerToken =
      'Token	949251c663b71f8b27afd37a10af87f3e8ed6a95';

  static String _authToken = '';

  static setAuthToken(String token) => _authToken = 'Token ' + token;

  // URLS
  static const String _authority = 'api.knctu.com';
  static const String _link = 'https://api.knctu.com/api/';

  static const String _userView = '${_link}user/';
  static const String _userList = '${_link}users/';

  static String _userDetail(String id) => '$_userView$id/';

  static const String _tokenView = '${_link}token/';

  static const String _groupView = '${_link}twix/group/';

  static String _groupDetail(String id) => '$_groupView$id/';

  static String _groupAdd(String id) => '${_groupDetail(id)}add/';

  static String _groupRemove(String id) => '${_groupDetail(id)}remove/';

  static const String _taskView = '${_link}twix/task/';
  static const String _assignedTaskView = '${_link}twix/assigned/tasks/';

  static String _assignedTaskDetail(String id) => '$_assignedTaskView$id';

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

  static Future<Response> getAllUsers({String email = ''}) {
    print(_authToken);
    Uri uri = Uri.https(_authority, 'api/users', {'email': email});
    return get(uri, headers: {HttpHeaders.authorizationHeader: _authToken});
  }

  // Twix App

  static Future<Response> createTask(
      {String id,
      String name,
      bool isDone,
      DateTime dueDate,
      DateTime remindMe,
      String boardId,
      bool isAssigned,
      String groupId}) {
    return post(_taskView, body: {
      'id': id,
      'name': name,
      'is_done': isDone,
      'due_date': dueDate,
      'remind_me': remindMe,
      'board_id': boardId,
      'is_assigned': isAssigned,
      'group_id': groupId
    }, headers: {
      HttpHeaders.authorizationHeader: _authToken
    });
  }

  static Future<Response> viewAssignedTask() {
    return get(_assignedTaskView,
        headers: {HttpHeaders.authorizationHeader: _authToken});
  }

  static Future<Response> updateAssignedTask(String id, bool isDone) {
    return patch(_assignedTaskDetail(id),
        body: {'is_done': isDone},
        headers: {HttpHeaders.authorizationHeader: _authToken});
  }

  static Future<Response> createGroup(String id, String name, String adminId) {
    return post(_groupView,
        body: {'id': id, 'name': name, 'admin_id': adminId},
        headers: {HttpHeaders.authorizationHeader: _authToken});
  }

  static Future<Response> addToGroup(String id, String user) {
    return post(_groupAdd(id),
        body: {'user': user},
        headers: {HttpHeaders.authorizationHeader: _authToken});
  }

  static Future<Response> removeFromGroup(String id, String user) {
    return post(_groupRemove(id),
        body: {'user': user},
        headers: {HttpHeaders.authorizationHeader: _authToken});
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
