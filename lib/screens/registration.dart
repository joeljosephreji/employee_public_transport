import 'package:employee_public_transport/templates/submit_button.dart';
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
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          InputTextbox('EMPLOYEE ID', employeeID, TextInputType.text),
          InputTextbox('USERNAME', username, TextInputType.text),
          InputTextbox('EMAIL', email, TextInputType.emailAddress),
          InputTextbox('MOBILE NO', mobileNo, TextInputType.number),
          InputTextbox('PASSWORD', password, TextInputType.text),
          SubmitButton('SIGN UP', () {
            // something
            print("hello");
          }),
        ],
      ),
    );
  }
}
