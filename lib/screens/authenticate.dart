import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mas_notas/Authentication/authenticate_bloc.dart';
import 'package:mas_notas/screens/login.dart';
import 'package:mas_notas/screens/register.dart';
import 'package:mas_notas/util/theme.dart';

class Authenticate extends StatelessWidget {
  Authenticate({Key key}) : super(key: key);
  AuthenticateBloc registerBloc;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    registerBloc = BlocProvider.of<AuthenticateBloc>(context);
    return buildRegisterWidget(height, width, context);
  }

  Container buildRegisterWidget(double height, double width, context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hint,
            hint.withAlpha(150),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment(6, 0.2),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              "Más Notas",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.combine(
                  [TextDecoration.overline],
                ),
                decorationStyle: TextDecorationStyle.dotted,
                decorationThickness: 0.5,
                letterSpacing: 3,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: registerBloc,
                            child: Login(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: width * 0.55,
                      height: height * 0.07,
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: accent,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white24,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: registerBloc,
                            child: Register(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: width * 0.55,
                      height: height * 0.07,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
