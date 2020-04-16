import 'package:brewcrewapp/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;

  BrewTile({ this.brew });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.brown[brew.strength],
                  backgroundImage: AssetImage('assets/coffee_icon.png'),
                ),
                title: Text(brew.name),
                subtitle: Text('Takes ${brew.sugars} sugar(s)'),
            ),
        ),
    );
  }
}