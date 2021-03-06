import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_task/models/Tasks.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/models/Users.dart';

class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }
}

class Network {
  final String _url = 'http://10.0.2.2:8000/api';
  //when using android studio emulator, change localhost to 10.0.2.2

  postData(data, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      var response =
          await SingletonDio.getDio().post(fullUrl, data: jsonEncode(data));
      print(response.headers);
      return response; // return json.decode(response.body)
    } catch (e) {
      var _error = e.toString();
      print(_error);
      return false;
    }
  }

  Future<List<User>> getPublicData(apiUrl) async {
    try {
      var response = await SingletonDio.getDio().get(_url + apiUrl,
          options: Options(headers: {"Authorization": "Bearer $_getToken()"}));
      if (response.statusCode == 200) {
        List<User> users =
            (response.data as List).map((x) => User.fromJson(x)).toList();
        return users;
      } else {
        return <User>[];
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<Task>> getTaskData(apiUrl) async {
    try {
      var response = await SingletonDio.getDio().get(_url + apiUrl,
          options: Options(headers: {"Authorization": "Bearer $_getToken()"}));
      print('dalal');
      print(response);
      if (response.statusCode == 200) {
        List<Task> tasks =
            (response.data as List).map((x) => Task.fromJson(x)).toList();
        print('dalal');
        print(tasks);
        print('dalal');
        return tasks;
      } else {
        return <Task>[];
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  // Map<String, String> _setHeaders = {
  //   'Content-Type': 'application/json',
  //   'Charset': 'utf-8',
  //   'Accept': 'application/json',
  //   // 'Cookie': 'cookie'
  // };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
