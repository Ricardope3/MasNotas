import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:mas_notas/models/class.dart';
import 'package:mas_notas/models/note.dart';

class NoteRepository {
  static String _baseUrl = "http://localhost:3000/dev/";
  static String _materias = "materias?";
  static String _get_notas = "get_notas?";
  static String _postNotas = "insertar_nota?";

  static Future<List<Class>> getClasses(int idSchedule) async {
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

  static Future<List<Note>> getNotes(int idClass) async {
    // idClass = 1; // TODO: REMOVE
    String _queryParams = "idclass=$idClass";
    String url = "$_baseUrl$_get_notas$_queryParams";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonObj = json.decode(response.body);
      List<Note> notes = [];
      jsonObj[0].forEach((_, val) {
        notes.add(Note.fromJson(val));
      });

      return notes;
    } else {
      return null;
    }
  }

  static Future<Note> postNote(int idClass) async {
    String _noteUrl;
    if (idClass == 3) {
      _noteUrl =
          "https://www.researchgate.net/profile/Anders_Bruun2/publication/281447608/figure/fig2/AS:364859632963585@1464000723191/Picture-of-the-whiteboard-with-colored-notes.png";
    } else {
      _noteUrl =
          "https://media.gettyimages.com/photos/whiteboard-with-notes-and-brainstorming-ideas-picture-id139624316";
    }
    String _queryParams = "idclass=$idClass&url=$_noteUrl";
    String url = "$_baseUrl$_postNotas$_queryParams";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return null;
    } else {
      return null;
    }
  }
}
