import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mas_notas/Authentication/authenticate_bloc.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/models/schedule.dart';
import 'package:mas_notas/repositories/schedules_repository.dart';
import 'package:mas_notas/util/theme.dart';

class Schedules extends StatefulWidget {
  const Schedules({Key key}) : super(key: key);

  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  List<Schedule> schedulesList = [];

  @override
  Widget build(BuildContext context) {
    String idUser = "";
    AuthenticateBloc authBloc = BlocProvider.of<AuthenticateBloc>(context);
    Authenticated authState = authBloc.state as Authenticated;
    idUser = authState.usuario.email;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary.withAlpha(30),
      appBar: AppBar(
        backgroundColor: accent,
        title: Text(
          "Más Notas",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (schedulesList.isNotEmpty) {
            String lastSchedulesName =
                schedulesList[schedulesList.length - 1].name;
            int lastIndex =
                int.parse(lastSchedulesName[lastSchedulesName.length - 1]);
            SchedulesRepository.registerSchedule(
              Schedule(
                  idUser: idUser,
                  url:
                      'https://masnotas.s3.us-east-2.amazonaws.com/schedules/schedule3.jpg',
                  name: 'Horario ' + (lastIndex + 1).toString()),
            ).then((response) {
              setState(() {});
            });
          } else {
            SchedulesRepository.registerSchedule(
              Schedule(
                  idUser: idUser,
                  url:
                      'https://masnotas.s3.us-east-2.amazonaws.com/schedules/schedule3.jpg',
                  name: 'Horario 1'),
            ).then((response) {
              setState(() {});
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: SchedulesRepository.getSchedules(idUser),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              schedulesList = snapshot.data;
              return SchedulesWidget(
                schedules: snapshot.data,
                height: height,
                width: width,
              );
            } else {
              return Center(
                child: Text(
                  "Error al recuperar los datos",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          }
          return Text("Algo Salio mal con el estado");
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

class SchedulesWidget extends StatelessWidget {
  const SchedulesWidget(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.schedules})
      : super(key: key);

  final double width;
  final double height;
  final List<Schedule> schedules;
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
              "Horarios",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Wrap(
              spacing: width * 0.05,
              runSpacing: width * 0.05,
              children: buildContainers(context, height, width, schedules),
            ),
          )
        ],
      ),
    );
  }
}

List<Container> buildContainers(BuildContext context, double height,
    double width, List<Schedule> schedules) {
  List<Container> materiaWidgets = [];
  for (var i = 0; i < schedules.length; i++) {
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
                schedules[i].url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 40),
            child: FlatButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/home',
                arguments: schedules[i].id,
              ),
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
                    schedules[i].name,
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
