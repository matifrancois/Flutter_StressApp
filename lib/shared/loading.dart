import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//widget para la animacion de cargado.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //el color de fondo del container (el background color)
      color: Colors.brown[100],
      //para que este en el centro de la pantalla.
      child: Center(
        //uso el spinKitChasingDots pero podemos usar el que queramos dentro de los disponibles
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
