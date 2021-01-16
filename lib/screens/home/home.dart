import 'package:flutter/material.dart';
import 'package:stressapp/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('StressApp'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        //las actions son widgets que apareceran en la appBar
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
    );
  }
}
