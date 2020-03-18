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
        children: <Widget>[
          InputTextbox('EMAIL', email, TextInputType.emailAddress),
          InputTextbox('PASSWORD', password, TextInputType.text),
        ],
      ),
    );
  }
}
