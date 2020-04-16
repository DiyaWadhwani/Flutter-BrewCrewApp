import 'package:brewcrewapp/services/auth.dart';
import 'package:brewcrewapp/shared_codes/constants.dart';
import 'package:brewcrewapp/shared_codes/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
    _RegisterState createState() => _RegisterState();
  }

  class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register With Brew Crew'),
        actions: <Widget> [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('SIGN IN'),
            onPressed: () {
              widget.toggleView();
            }
          )
        ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
        child: Form(
          key: _formKey,
            child: Column(
                children: <Widget> [

                  SizedBox(height:20.0),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                    ),
                      validator: (val) => val.isEmpty ? 'Enter valid email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }
                  ),

                  SizedBox(height:20.0),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter password 6+ chars long' : null,
                    onChanged: (val) {
                      setState (() => password = val);
                    },
                  ),

                  SizedBox(height:50.0),

                  RaisedButton(
                      color: Colors.green[400],
                      child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          )
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.regEmailPass(email, password);
                          if(result == null)
                            setState(() {
                              error = 'Invalid Email';
                              loading = false;
                          });
                        }
                      }
                  ),

                  SizedBox(height:50.0),

                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                  )

                ]
            )
        ),
      ),
    );
  }
  }