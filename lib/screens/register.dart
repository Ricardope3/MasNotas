import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mas_notas/Authentication/authenticate_bloc.dart';
import 'package:mas_notas/Authentication/authenticate_event.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/models/user.dart';
import 'package:mas_notas/util/theme.dart';

class Register extends StatelessWidget {
  Register({Key key}) : super(key: key);
  double height;
  double width;
  AuthenticateBloc registerBloc;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    registerBloc = BlocProvider.of<AuthenticateBloc>(context);
    return Scaffold(
      body: BlocListener<AuthenticateBloc, AuthenticateState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, "/navWrapper");
          } else if (state is AuthenticateError) {
            final snackBar = SnackBar(content: Text('Error en el registro'));
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) {
            if (state is AuthenticateInitial) {
              return buildRegisterWidget(context);
            } else if (state is Authenticating) {
              return buildRegisteringWidget(context);
            } else if (state is Authenticated) {
              return buildRegisteredWidget();
            }
            return buildRegisterWidget(context);
          },
        ),
      ),
    );
  }

  Scaffold buildRegisterWidget(BuildContext context) {
    String _email = "";
    String _name = "";
    String _password = "";
    return Scaffold(
      backgroundColor: accent,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    light.withAlpha(200),
                    Colors.white,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment(20, -5),
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
                      blurRadius: 10,
                      spreadRadius: 5,
                      color: Colors.black.withOpacity(0.10),
                    ),
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
              top: height * 0.23,
              left: width * 0.05,
              child: Column(
                children: <Widget>[
                  Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: height * 0.32,
              left: width * 0.05,
              child: Container(
                height: height,
                width: width * 0.55,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (val) {
                          _name = val;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: hint,
                            size: 20,
                          ),
                          hintText: "Usuario",
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (val) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: hint,
                            size: 20,
                          ),
                          hintText: "Confirmar contraseña",
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
      ),
      floatingActionButton: Container(
        width: width * 0.4,
        padding: EdgeInsets.all(width * 0.07),
        child: FittedBox(
          child: FloatingActionButton(
            splashColor: light,
            onPressed: () {
              registerBloc.add(
                OnRegister(
                  user: User(
                    name: _name,
                    email: _email,
                    password: _password,
                  ),
                ),
              );
            },
            backgroundColor: hint,
            hoverElevation: 100,
            child: Icon(
              Icons.arrow_forward,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisteredWidget() {
    return Scaffold(body: Center(child: Text("Redireccionando")));
  }

  Widget buildRegisteringWidget(BuildContext context) {
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
