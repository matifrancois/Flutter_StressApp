import 'package:flutter/material.dart';
import 'package:stressapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:stressapp/services/auth.dart';
import 'package:stressapp/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      //creamos una instancia de authService y accedemos a user de ella
      //entonces los hijos de esto, van a poder acceder a esa data ejemplo el wrapper
      value: AuthService().user,
      child: MaterialApp(
        //para que cargue el wrapper
        home: Wrapper(),
      ),
    );
  }
}
