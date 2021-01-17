import 'package:flutter/material.dart';

const NUMOFCOLORS = 3; //Green, yellow and red
const GREEN = 0;
const YELLOW = 1;
const RED = 2;

const textInputDecoration = InputDecoration(

    ///*Pondria el hintText si quisiera que todos digan lo mismo, pero no va a ser el caso casi nunca, entonces la mejor forma es con el metodo copyWith al usarlo como usamos aca. */
    //hintText: 'Email'
    ///*Podes poner las 2 lineas de ahi abajo para que aparezca en rectangulitos blancos lo que hay que poner*/
    //fillColor: Colors.white,
    //filled: true,
    ///*lo que sigue es para que aparezca un borde extra cuando no se presiona (recomendable usarlo del mismo color del fondo para despues poder poner otro color al seleccionar*/
    //enabledBorder: OutlineInputBorder(
    //borderSide: BorderSide(
    //color: Colors.white,
    //width: 2.0)
    //)
    ///*Esto es para cuando queremos que aparezca un borde al rededor del recuadro al presionar en el recuadro*/
    //focusedBorder: OutlineInputBorder(
    //borderSide: BorderSide(
    //color: Colors.pink,
    //width: 2.0)
    //)
    );
