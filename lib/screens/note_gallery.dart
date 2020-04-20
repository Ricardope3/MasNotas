import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mas_notas/util/theme.dart';
import 'package:mas_notas/models/note.dart';
import 'package:mas_notas/repositories/notes_repository.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path/path.dart';

class NoteGallery extends StatefulWidget {
  const NoteGallery({Key key}) : super(key: key);

  @override
  _NoteGalleryState createState() => _NoteGalleryState();
}

class _NoteGalleryState extends State<NoteGallery> {
  @override
  Widget build(BuildContext context) {
    final int idClass = ModalRoute.of(context).settings.arguments;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imageFile = await ImagePicker.pickImage(
            source: ImageSource.gallery,
          );
          if (imageFile == null) {
            return;
          }
          Note nota = await NoteRepository.postNote(idClass);
          setState(() {
            
          });
        },
        child: Icon(
          Icons.camera_alt,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: accent,
          title: Text(
            "Más Notas",
          ),
          elevation: 0),
      // body: GridView.extent(
      //   maxCrossAxisExtent: width / 3,
      //   mainAxisSpacing: 5.0,
      //   crossAxisSpacing: 5.0,
      //   padding: EdgeInsets.all(5.0),
      //   children: _buildImageGrid(context),
      // )
      body: FutureBuilder(
          future: NoteRepository.getNotes(idClass), // TODO: CHANGE THIS BOII
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loading(context);
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return GridView.extent(
                  maxCrossAxisExtent: width / 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  padding: EdgeInsets.all(5.0),
                  children: _buildImageGrid(context, snapshot.data),
                );
              } else {
                return Text("Error al recuperar las notas");
              }
            }
          }),
    );
  }

  Widget loading(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          child: LoadingIndicator(
            indicatorType: Indicator.ballTrianglePath,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  List<Container> _buildImageGrid(BuildContext context, List<Note> notes) {
    List<Container> list = [];

    for (var i = 0; i < notes.length; i++) {
      Container con = Container(
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              backgroundColor: hint,
              body: Center(child: Image.network(notes[i].url)),
            );
          }));
        },
        child: Image.network(
          notes[i].url,
          fit: BoxFit.cover,
        ),
      ));
      list.add(con);
    }
    return list;
  }
}
