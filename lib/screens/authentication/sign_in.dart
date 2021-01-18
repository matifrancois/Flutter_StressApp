import 'package:flutter/material.dart';
import 'package:stressapp/services/auth.dart';
import 'package:stressapp/shared/constants.dart';
import 'package:stressapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  //El constructor de la clase
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //creo una instancia de la clase authservice del archivo auth dentro de este archivo
  final AuthService _authent = AuthService();
  final _formKey = GlobalKey<FormState>();
  //una bandera que nos permite indicar si esta o no cargando, en base a eso decidimos que retornar con el operador ternario
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //si esta en loading que retorne el widget loading, pero si no esta en loading entonces que devuelva el scaffold
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[800],
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.white),
                  label:
                      Text('Register', style: TextStyle(color: Colors.white)),
                  onPressed: () => {widget.toggleView()},
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      //onchange hace que cada vez que cambie lo que se tipea se abra la funcion
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        //para controlar lo que queremos que aparezca si no fue valido lo que pusimos al apretar el boton
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          //con esto updateamos la variable email con lo que este en el text imput cada vez que se varia un caracter dentro
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        //obscure para que tenga el formato de un text input de contraseña
                        obscureText: true,
                        //para controlar lo que queremos que aparezca si no fue valido lo que pusimos al apretar el boton
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,

                        onChanged: (val) {
                          //con esto updateamos la variable email con lo que este en el text imput cada vez que se varia un caracter dentro
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //modificamos el valor de loading
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authent
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.teal[400],
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
