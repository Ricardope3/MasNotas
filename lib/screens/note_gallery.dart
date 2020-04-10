import 'package:flutter/material.dart';
import 'package:mas_notas/util/theme.dart';

class NoteGallery extends StatelessWidget {
  const NoteGallery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: hint,
        appBar: AppBar(
            title: Text(
              "Más Notas",
            ),
            elevation: 0),
        body: GridView.extent(
          maxCrossAxisExtent: width / 3,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          padding: EdgeInsets.all(5.0),
          children: _buildImageGrid(),
        )
    );
  }

  List<Container> _buildImageGrid() {
    List<String> im = [
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80",
      "https://images.unsplash.com/photo-1580842455689-d11052308c25?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=927&q=80",
      "https://images.unsplash.com/photo-1581092575198-f8970a271aa0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
      "https://images.unsplash.com/photo-1580894740397-0946742deb4b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532101780307-8f873ece858f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1581089778245-3ce67677f718?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1453733190371-0a9bedd82893?ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80",
      "https://images.unsplash.com/photo-1580842455689-d11052308c25?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=927&q=80",
      "https://images.unsplash.com/photo-1581092575198-f8970a271aa0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
      "https://images.unsplash.com/photo-1580894740397-0946742deb4b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532101780307-8f873ece858f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1581089778245-3ce67677f718?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1453733190371-0a9bedd82893?ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1565310959460-eeeac31791ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80"
    ];
    List<Container> list = [];

    for (var i = 0; i < im.length; i++) {
      Container con = Container(child: Image.network(
        im[i],
        fit: BoxFit.cover,
        )
      );
      list.add(con);
    }
    return list;
  }
}
