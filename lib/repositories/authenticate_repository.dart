import 'dart:convert';

import 'package:mas_notas/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  String _baseUrl = "http://localhost:3000/dev/";
  String _register = "registro?";
  String _login = "login?";

  Future<User> register(User user) async {
    String _queryParams =
        "email=${user.email}&name=${user.name}&password=${user.password}";
    String url = "$_baseUrl$_register$_queryParams";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return user;
    } else {
      return null;
    }
  }

  Future<User> login(User user) async {
    String _queryParams = "email=${user.email}";
    String url = "$_baseUrl$_login$_queryParams";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonObj = json.decode(response.body);
      return User(
          email: user.email, password: user.password, name: jsonObj[0]['name']);
    } else {
      return null;
    }
  }
}
