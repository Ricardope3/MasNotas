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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              child: Text(
                "Notas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Wrap(
                spacing: width * 0.05,
                runSpacing: width * 0.05,
                children: buildContainers(height, width),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Container> buildContainers(double height, double width) {
    List<String> im = [
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      "https://images.unsplash.com/photo-1532622785990-d2c36a76f5a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
    ];
    List<Container> lista = [];

    for (var i = 0; i < im.length; i++) {
      Container con = Container(
        child: Stack(
          children: <Widget>[
            Image.network(
              im[i],
            ),
          ],
        ),
      );
      lista.add(con);
    }
    return lista;
  }
}
