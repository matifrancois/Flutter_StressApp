import 'package:flutter/material.dart';
import 'package:stressapp/screens/authentication/sign_in.dart';
import 'package:stressapp/screens/authentication/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSingIn = true;

  // Esta funcion nos permite cambias las vistas de nuestra app
  void toggleView() {
    setState(() {
      showSingIn = !showSingIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSingIn) {
      //le tenemos que pasar a la clase la funcion a la que necesitamos acceder dentro
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
