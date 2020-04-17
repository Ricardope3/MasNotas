import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mas_notas/Authentication/authenticate_bloc.dart';
import 'package:mas_notas/Authentication/authenticate_event.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/models/user.dart';
import 'package:mas_notas/util/theme.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
  double height;
  double width;
  AuthenticateBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    loginBloc = BlocProvider.of<AuthenticateBloc>(context);
    return Scaffold(
      body: BlocListener<AuthenticateBloc, AuthenticateState>(
        listener: (context, state) {
          if (state is AuthenticateError) {
            final snackBar = SnackBar(content: Text('Error al iniciar sesion'));
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) {
            if (state is AuthenticateInitial) {
              return buildLoginWidget(context);
            } else if (state is Authenticating) {
              return buildLoggingWidget(context);
            } else if (state is Authenticated) {
              return buildLoggedWidget();
            }
            return buildLoginWidget(context);
          },
        ),
      ),
    );
  }

  Widget buildLoginWidget(BuildContext context) {
    String _email = "";
    String _password = "";
    return Scaffold(
      backgroundColor: accent,
      body: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent,
                  hint.withOpacity(1),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment(1, -1),
              ),
            ),
          ),
          Transform(
            child: Container(
              width: height,
              height: height * 0.48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
            ),
            transform: Matrix4.identity()
              ..rotateZ(3.1415 / 4)
              ..scale(1.6)
              ..translate(-20.0),
          ),
          Transform(
            child: Container(
              width: height * 0.5,
              height: height * 0.35,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 10,
                  )
                ],
              ),
            ),
            transform: Matrix4.identity()
              ..translate(width * 0.8, height * 0.87)
              ..rotateZ(3.1415 / 4)
              ..translate(0.0, -height * 0.14),
            // ..scale(1.6)
          ),
          Positioned(
            top: height * 0.3,
            left: width * 0.05,
            child: Column(
              children: <Widget>[
                Text(
                  "Ingresar",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.42,
            left: width * 0.05,
            child: Container(
              height: height,
              width: width * 0.55,
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) {
                        _email = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: hint,
                          size: 20,
                        ),
                        hintText: "Correo",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        _password = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: hint,
                          size: 20,
                        ),
                        hintText: "Contraseña",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: width * 0.4,
        padding: EdgeInsets.all(width * 0.07),
        child: FittedBox(
          child: FloatingActionButton(
            splashColor: light,
            onPressed: () {
              loginBloc.add(
                OnLogin(
                  user: User(
                    email: _email,
                    password: _password,
                  ),
                ),
              );
            },
            backgroundColor: light,
            hoverElevation: 100,
            child: Icon(
              Icons.arrow_forward,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoggedWidget() {
    return Scaffold(body: Center(child: Text("Redireccionando")));
  }

  Widget buildLoggingWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          child: LoadingIndicator(
            indicatorType: Indicator.pacman,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
