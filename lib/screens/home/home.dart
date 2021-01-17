import 'package:flutter/material.dart';
import 'package:stressapp/screens/home/settings_form.dart';
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
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Stress>>.value(
      value: DatabaseService().stress,
      child: Scaffold(
        appBar: AppBar(
          title: Text('StressApp'),
          backgroundColor: Colors.blueGrey[800],
          elevation: 0.0,
          //las actions son widgets que apareceran en la appBar
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text('State', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
            child: StressList()),
      ),
    );
  }
}
