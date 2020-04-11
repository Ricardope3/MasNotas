import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:mas_notas/models/class.dart';

class NoteRepository {
  static String _baseUrl = "http://localhost:3000/";
  static String _materias = "materias?";

  static Future<List<Class>> getClasses(int idSchedule) async {
    idSchedule = 1; //TODO: REMOVE WHEN GET SCHEDULES IS READY
    String _queryParams = "idschedule=$idSchedule";
    String url = "$_baseUrl$_materias$_queryParams";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonObj = json.decode(response.body);
      List<Class> classes = [];
      jsonObj[0].forEach((_, val) {
        classes.add(Class.fromJson(val));
      });
      return classes;
    } else {
      return null;
    }
  }
}
