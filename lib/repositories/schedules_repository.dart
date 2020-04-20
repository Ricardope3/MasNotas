import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:mas_notas/models/schedule.dart';

class SchedulesRepository {
  static String _baseUrl = "https://hnbcxspqtf.execute-api.us-east-1.amazonaws.com/dev/";
  static String _horario_get = "horario_get?";
  static String _horario_registro = "horario_registro?";

  static Future<List<Schedule>> getSchedules(String idUser) async {
    String _queryParams = "iduser=$idUser";
    String url = "$_baseUrl$_horario_get$_queryParams";
    http.Response response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonObj = json.decode(response.body);
      List<Schedule> classes = [];
      jsonObj[0].forEach((_, val) {
        classes.add(Schedule.fromJson(val));
      });
      return classes;
    } else {
      return null;
    }
  }

  static Future<Schedule> registerSchedule(Schedule schedule) async {
    
    String _queryParams =
        "iduser=${schedule.idUser}&url=${schedule.url}&nombre=${schedule.name}";
    String url = "$_baseUrl$_horario_registro$_queryParams";
    http.Response response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      return schedule;
    } else {
      return null;
    }
  }
}
