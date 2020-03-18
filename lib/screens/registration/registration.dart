import 'package:flutter/material.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController employeeID = new TextEditingController();
    TextEditingController username = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController mobileNo = new TextEditingController();
    TextEditingController password = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputTextbox('EMPLOYEE ID', employeeID, TextInputType.text),
          InputTextbox('USERNAME', username, TextInputType.text),
          InputTextbox('EMAIL', email, TextInputType.emailAddress),
          InputTextbox('MOBILE NO', mobileNo, TextInputType.number),
          InputTextbox('PASSWORD', password, TextInputType.text),
        ],
      ),
    );
  }
}
