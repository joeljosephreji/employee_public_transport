import 'package:employee_public_transport/templates/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          InputTextbox('EMAIL', email, TextInputType.emailAddress),
          InputTextbox('PASSWORD', password, TextInputType.text),
          SubmitButton('LOG IN', () {
            // something
            print("hello world");
          }),
          SubmitButton('REGISTRATION', () {
            Navigator.of(context).pushNamed('/signup');
          }),
        ],
      ),
    );
  }
}
