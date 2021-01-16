import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stressapp/services/auth.dart';
import 'package:stressapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stressapp/screens/home/stress_list.dart';
import 'package:stressapp/models/stress.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      //show modal bottom sheet nos permite hacer el desplegable donde vamos
      //a poner las cosas que queramos que el usuario introduzca
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text('bottom sheet'),
            );
          });
    }

    return StreamProvider<List<Stress>>.value(
      value: DatabaseService().stress,
      child: Scaffold(
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
              label: Text('logout'),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings'))
          ],
        ),
        body: StressList(),
      ),
    );
  }
}
