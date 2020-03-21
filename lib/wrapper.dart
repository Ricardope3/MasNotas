import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/screens/authenticate.dart';
import 'package:mas_notas/screens/home.dart';

import 'Authentication/authenticate_bloc.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool authenticated = false;
  AuthenticateBloc authBloc = AuthenticateBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => authBloc,
      child: BlocListener(
        bloc: authBloc,
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pop(context);
            authenticated = true;
          }
        },
        child: Scaffold(
          body: authenticated ? Home() : Authenticate(),
        ),
      ),
    );
  }
}
