import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stressapp/screens/authentication/autenticate.dart';
import 'package:stressapp/screens/home/home.dart';
import 'package:stressapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // Return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
