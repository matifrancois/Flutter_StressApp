import 'package:flutter/material.dart';
import 'package:stressapp/shared/constants.dart';

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
            decoration: textInputDecoration.copyWith(hintText: 'Enter Name'),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(
            height: 20.0,
          ),
          //dropdown
          DropdownButtonFormField(
            //esto es para que empiece en ese valor (tiene que ser uno de los valores de la lista, sino dara error)
            value: _currentDescription ?? 'At Home',
            items: description.map((desc) {
              return DropdownMenuItem(
                //value sera lo que selecciones
                value: desc,
                child: Text('$desc'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentDescription = val),
          ),
          //slider
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentDescription);
              print(_currentStress);
            },
          )
        ],
      ),
    );
  }
}
