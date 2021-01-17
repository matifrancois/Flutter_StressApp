//este archivo es el responsable de lo que aparece en el home
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stressapp/models/stress.dart';
import 'package:stressapp/screens/home/stress_tile.dart';

class StressList extends StatefulWidget {
  @override
  _StressListState createState() => _StressListState();
}

class _StressListState extends State<StressList> {
  @override
  Widget build(BuildContext context) {
    // el [] es porque al principio sino te tira error porque no existe.
    final stress = Provider.of<List<Stress>>(context) ?? [];
    // stress.forEach((stress) {
    //   print(stress.name);
    //   print(stress.description);
    //   print(stress.stress);
    // });

    return ListView.builder(
        itemCount: stress.length,
        //index iterará en la lista de stress
        itemBuilder: (context, index) {
          return StressTile(stress: stress[index]);
        });
  }
}
