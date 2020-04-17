import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:mas_notas/models/schedule.dart';

class SchedulesRepository {
  static String _baseUrl = "http://localhost:3000/dev/";
  static String _horario_get = "horario_get?";
  static String _horario_registro = "horario_registro?";

  static Future<List<Schedule>> getSchedules(String idUser) async {
    String _queryParams = "iduser=$idUser";
    String url = "$_baseUrl$_horario_get$_queryParams";
    print(url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonObj = json.decode(response.body);
      List<Schedule> classes = [];
      print(jsonObj);
      jsonObj.forEach((val) {
        print(val);
        classes.add(Schedule.fromJson(val));
      });
      return classes;
    } else {
      return null;
    }

    // List<Schedule> schedules = [];
    // schedules.add( Schedule(id: 2, idUser: 'ricky@google.com', url: 'https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80', name: 'Horario 1'));
    // schedules.add( Schedule(id: 2, idUser: 'ricky@google.com', url: 'https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80', name: 'Horario 2'));
    // schedules.add( Schedule(id: 2, idUser: 'ricky@google.com', url: 'https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80', name: 'Horario 3'));
    // return schedules;

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
