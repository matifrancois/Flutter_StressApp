import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//widget para la animacion de cargado.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //el color de fondo del container (el background color)
      color: Colors.white,
      //para que este en el centro de la pantalla.
      child: Center(
        //uso el spinKitChasingDots pero podemos usar el que queramos dentro de los disponibles
        child: SpinKitWave(
          color: Colors.teal[400],
          size: 50.0,
        ),
      ),
    );
  }
}
