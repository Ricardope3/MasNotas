import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mas_notas/models/class.dart';
import 'package:mas_notas/repositories/notes_repository.dart';
import 'package:mas_notas/util/theme.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int idSchedule = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary.withAlpha(70),
      appBar: AppBar(
        backgroundColor: accent,
        title: Text(
          "Más Notas",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: NoteRepository.getClasses(idSchedule),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return MateriasWidget(
                classes: snapshot.data,
                height: height,
                width: width,
              );
            } else {
              return Center(
                child: Text(
                  "Este horario aun no tiene materias",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          return Text("Error en el estado de la app");
        },
      ),
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
}

class MateriasWidget extends StatelessWidget {
  const MateriasWidget(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.classes})
      : super(key: key);

  final double width;
  final double height;
  final List<Class> classes;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 40,
            ),
            child: Text(
              "Materias",
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
              children: buildContainers(context, height, width, classes),
            ),
          )
        ],
      ),
    );
  }
}

List<Container> buildContainers(
    BuildContext context, double height, double width, List<Class> classes) {
  List<Container> materiaWidgets = [];
  for (var i = 0; i < classes.length; i++) {
    Container con = Container(
      padding: EdgeInsets.only(bottom: 20),
      height: height * 0.17,
      width: width * 0.45,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              child: Image.network(
                classes[i].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 40),
            child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/note_gallery',
                  arguments: classes[i].id),
              highlightColor: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    classes[i].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    materiaWidgets.add(con);
  }
  return materiaWidgets;
}
