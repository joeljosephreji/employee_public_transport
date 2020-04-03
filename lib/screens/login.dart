import 'dart:convert';

import 'package:employee_public_transport/templates/alert_box.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';
import 'package:employee_public_transport/templates/io_classes.dart';
import 'package:employee_public_transport/templates/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController mail = new TextEditingController();
    TextEditingController password = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          InputTextbox('EMAIL', mail, TextInputType.emailAddress, false),
          InputTextbox('PASSWORD', password, TextInputType.text, true),
          SubmitButton('SIGN IN', () async {
            var map = new Map<String, dynamic>();

            map['password'] = password.text;
            map['email'] = mail.text;
            var res = await loginPost(map);

            if (res != null) {
              if (res.success) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var token = res.about['data']['token'];
                var name = res.about['data']['name'];
                // print(token);
                prefs.setString('USER_TOKEN', token);
                prefs.setString('__UID', res.about['comment'].toString());
                prefs.setString('__UNAME', name);
                Navigator.pushNamed(context, '/home', arguments: name);
              } else {
                await showAlertBox(context, "Unsucessful Login",
                    "Oops..Login Failed..! Try Again");
              }
            } else {
              await showAlertBox(
                  context, "ERROR", "Something went wrong..! Please try Again");
            }
          }),
          SubmitButton('REGISTRATION', () {
            Navigator.of(context).pushNamed('/signup');
          }),
        ],
      ),
    );
  }
}

Future<dynamic> loginPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/employee/login';

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
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
