import 'package:flutter/material.dart';
import 'package:mas_notas/screens/note_gallery.dart';
import 'package:mas_notas/util/theme.dart';
import 'package:mas_notas/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: Wrapper(),
      routes: <String, WidgetBuilder> {
      '/note_gallery': (BuildContext context) => NoteGallery()
    },
    );
  }
}
