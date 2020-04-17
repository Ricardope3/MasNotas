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
    // List<String> im = [
    //   "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80",
    //   "https://images.unsplash.com/photo-1580842455689-d11052308c25?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=927&q=80",
    //   "https://images.unsplash.com/photo-1581092575198-f8970a271aa0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
    //   "https://images.unsplash.com/photo-1580894740397-0946742deb4b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1532101780307-8f873ece858f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1581089778245-3ce67677f718?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1453733190371-0a9bedd82893?ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
    //   "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80",
    //   "https://images.unsplash.com/photo-1580842455689-d11052308c25?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=927&q=80",
    //   "https://images.unsplash.com/photo-1581092575198-f8970a271aa0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
    //   "https://images.unsplash.com/photo-1580894740397-0946742deb4b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1532101780307-8f873ece858f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1581089778245-3ce67677f718?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1453733190371-0a9bedd82893?ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
    //   "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    //   "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80"
    // ];
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
