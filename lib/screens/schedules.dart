import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mas_notas/Authentication/authenticate_bloc.dart';
import 'package:mas_notas/models/schedule.dart';
import 'package:mas_notas/repositories/schedules_repository.dart';
import 'package:mas_notas/util/theme.dart';

class Schedules extends StatelessWidget {
  const Schedules({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticateBloc authBloc = BlocProvider.of<AuthenticateBloc>(context);
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
      body: FutureBuilder(
        future: SchedulesRepository.getSchedules("rafa@google.com"),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return SchedulesWidget(schedules: snapshot.data,height: height,width: width,);
            } else {
              return Text("Error al recuperar los datos");
            }
          }
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
            indicatorType: Indicator.ballTrianglePath ,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

class SchedulesWidget extends StatelessWidget {
  const SchedulesWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required this.schedules
  }) : super(key: key);

  final double width;
  final double height;
  final List<Schedule> schedules;
  @override
  Widget build(BuildContext context,) {
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

List<Container> buildContainers(
    BuildContext context, double height, double width,List<Schedule> schedules) {

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
              onPressed: () => Navigator.pushNamed(context, '/home', arguments: schedules[i].id),
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
