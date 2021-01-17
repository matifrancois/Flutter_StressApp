import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stressapp/models/user.dart';
import 'package:stressapp/services/database.dart';
import 'package:stressapp/shared/constants.dart';
import 'package:stressapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> description = [
    'Working',
    'Drinking coffee',
    'Having Fun',
    'Watching Netflix',
    'At Home'
  ];

  //form values
  String _currentName;
  String _currentDescription;
  int _currentStress;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Color colorSlider(state) {
      switch (state) {
        case GREEN:
          return Colors.green;
          break;
        case YELLOW:
          return Colors.yellow;
          break;
        case RED:
          return Colors.red;
          break;
        default:
      }
    }

    String textSlider(state) {
      switch (state) {
        case GREEN:
          return 'Free';
          break;
        case YELLOW:
          return 'Ok';
          break;
        case RED:
          return 'Busy';
          break;
        default:
      }
    }

    return StreamBuilder<UserData>(
        //con esto le decimos que escuchamos a ese stream en este widget
        stream: DatabaseService(uid: user.uid).userData,
        //ese snapshot no tiene nada que ver con firebase, refiere a la data que baja por el stream
        builder: (context, snapshot) {
          //con esto comprobamos que haya una diferencia para no tener que cargar todo el tiempo de firebase que tarda un rato
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your state',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter Name'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    //esto es para que empiece en ese valor (tiene que ser uno de los valores de la lista, sino dara error)
                    value: _currentDescription ?? userData.description,
                    items: description.map((desc) {
                      return DropdownMenuItem(
                        //value sera lo que selecciones
                        value: desc,
                        child: Text('$desc'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentDescription = val),
                  ),
                  //slider
                  SizedBox(height: 20.0),
                  Text(
                    textSlider((_currentStress) ?? userData.stress),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Slider(
                      //usa esos numeros porque con eso controla el color
                      //la version mas prolija que encontre usar, una lista, pero deberia haber otra forma mejor
                      //trate con enum pero no funcionan bien en dart al parecer.
                      min: GREEN.toDouble(),
                      max: RED.toDouble(),
                      // -1 debido a que es el numero de divisiones no de objetos
                      divisions: NUMOFCOLORS - 1,
                      // el method toDouble es necesario porque _currentStress es int y necesitas double para el slider
                      //si correntStress no tiene valor es decir no se modifico en ese momento entonces toma el valor almacenado en firebase
                      value: ((_currentStress) ?? userData.stress).toDouble(),
                      //las siguientes 2 lineas colorean el slider la parte activa y la no activa
                      activeColor:
                          colorSlider(((_currentStress) ?? userData.stress)),
                      inactiveColor:
                          colorSlider(((_currentStress) ?? userData.stress)),
                      //round method nos permite castear el float que devuelve el slide a int
                      onChanged: (val) =>
                          setState(() => _currentStress = val.round())),
                  RaisedButton(
                    color: Colors.blueGrey[800],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            //los ?? son porque si no los modificamos quedaria null entonces en lugar de null en ese caso querriamos usar el que ya esta cargado en firestore
                            _currentDescription ?? userData.description,
                            _currentName ?? userData.name,
                            _currentStress ?? userData.stress);
                        //esto baja el cartel para las settings al apretar el boton
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
