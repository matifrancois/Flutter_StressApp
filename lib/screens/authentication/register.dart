import 'package:flutter/material.dart';
import 'package:stressapp/services/auth.dart';
import 'package:stressapp/shared/constants.dart';
import 'package:stressapp/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  //El constructor de la clase
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authent = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[800],
              elevation: 0.0,
              title: Text('Sign up'),
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person, color: Colors.white),
                    label:
                        Text('Sing in', style: TextStyle(color: Colors.white)),
                    onPressed: () => {
                          //widget regiere a todo este widget Register
                          widget.toggleView()
                        })
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  //asocio esa global formkey a esta form (nos ayuda con la validacion)
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      //onchange hace que cada vez que cambie lo que se tipea se abra la funcion
                      TextFormField(
                        //esto es para que aparezca el textito antes de completar el campo y algunas cosas de estilo como el borde al rededor del text input
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
                        //obscure para que tenga el formato de un text input de contraseña
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                          //nos aseguramos si la form es valida o no
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authent
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'please supply a valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.teal[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      //siempre se muestra esto solo que al no tener errores error es un string vacio
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
