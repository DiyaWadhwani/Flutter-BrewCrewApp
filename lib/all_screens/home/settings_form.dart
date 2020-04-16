import 'package:brewcrewapp/models/user.dart';
import 'package:brewcrewapp/services/database.dart';
import 'package:brewcrewapp/shared_codes/constants.dart';
import 'package:brewcrewapp/shared_codes/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  final List<int> strength = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  //form values
  String _currName;
  String _currSugars;
  int _currStrength;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
    stream: DBService(uid: user.uid).userData,
    builder: (context, snapshot){
      if(snapshot.hasData) {

        UserData userdata = snapshot.data;

        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Text(
                    'Update brew settings',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),

                SizedBox(height: 50.0),

                TextFormField(
                  initialValue: userdata.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currName = val),
                ),

                SizedBox(height: 20.0),

                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currSugars ?? userdata.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text ('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currSugars = val),
                ),

                SizedBox(height: 20.0),

                //slider
                Slider(
                  value: (_currStrength ?? userdata.strength).toDouble(),
                  activeColor: Colors.brown[_currStrength ?? userdata.strength],
                  inactiveColor: Colors.brown[_currStrength ?? userdata.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currStrength = val.round()),
                ),

                SizedBox(height: 50.0),

                RaisedButton(
                  color: Colors.purple,
                  elevation: 2.0,
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DBService(uid: user.uid).updateUserData(
                        _currName ?? userdata.name,
                        _currSugars ?? userdata.sugars,
                        _currStrength ?? userdata.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                )

              ],
            )
        );
      }
      else {
        return Loading();
      }
    }
    );
  }
}