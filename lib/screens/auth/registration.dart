import 'dart:convert';

import 'package:employee_public_transport/templates/alert_box.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';
import 'package:employee_public_transport/templates/io_classes.dart';
import 'package:employee_public_transport/templates/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          InputTextbox('EMPLOYEE ID', employeeID, TextInputType.text, false),
          InputTextbox('USERNAME', username, TextInputType.text, false),
          InputTextbox('EMAIL', email, TextInputType.emailAddress, false),
          InputTextbox('MOBILE NO', mobileNo, TextInputType.number, false),
          InputTextbox('PASSWORD', password, TextInputType.text, true),
          SubmitButton('SIGN UP', () async {
            var map = new Map<String, dynamic>();

            // map['userName'] = username.text;
            // map['email'] = email.text;
            // map['password'] = password.text;
            // map['mobileNo'] = mobileNo.text;
            // map['employee_id'] = employeeID.text;
            map['userName'] = "Employee Soman";
            map['email'] = "samanyu@cet.ac.in";
            map['password'] = "12345678";
            map['mobileNo'] = "8281812793";
            map['employee_id'] = "007";

            var res = await registerPost(map);

            if (res != null) {
              if (res.success) {
                Navigator.of(context)
                    .pushNamed('/confirmpage', arguments: res.about);
              } else {
                if (res.status == 409) {
                  await showAlertBox(context, "ERROR",
                      res.about['comment'] + ' - ALREADY EXISTS..!');
                }
              }
            }
          }),
        ],
      ),
    );
  }
}

Future<dynamic> registerPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/employee/register';

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    // print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
