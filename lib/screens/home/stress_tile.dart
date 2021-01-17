import 'package:flutter/material.dart';
import 'package:stressapp/models/stress.dart';
import 'package:stressapp/shared/constants.dart';

class StressTile extends StatelessWidget {
  final Stress stress;
  StressTile({this.stress});
  @override
  Widget build(BuildContext context) {
    String text = '';
    Color functionColor() {
      switch (stress.stress.round()) {
        case GREEN:
          text = 'Free';
          return Colors.green;
          break;
        case YELLOW:
          text = 'Ok';
          return Colors.yellow;
          break;
        case RED:
          text = 'Busy';
          return Colors.red;
          break;
        default:
          return Colors.black;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: functionColor(),
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
            radius: 25.0,
          ),
          title: Text(stress.name),
          subtitle: Text(stress.description),
        ),
      ),
    );
  }
}
