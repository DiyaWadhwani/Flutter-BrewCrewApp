import 'package:brewcrewapp/all_screens/home/settings_form.dart';
import 'package:brewcrewapp/models/brew.dart';
import 'package:brewcrewapp/services/auth.dart';
import 'package:brewcrewapp/services/database.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget{

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      }
      );
    }

    return StreamProvider<List<Brew>>.value(
    value: DBService().brews,
    child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[

          FlatButton.icon(
            icon: Icon(Icons.person),
            label : Text(
              'LOGOUT'
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),

          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text(
                'SETTINGS'
            ),
            onPressed: () => _showSettingsPanel(),
          ),

        ],
      ),
//body: BrewList(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BrewList(),
      )
    ));
  }
}