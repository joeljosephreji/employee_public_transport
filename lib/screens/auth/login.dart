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
    TextEditingController _employeeID = new TextEditingController();
    TextEditingController _password = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KSRTC Admin Login",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          Center(
            child: Icon(
              Icons.people,
              size: 70,
              color: Colors.teal,
            ),
          ),
          InputTextbox(
              'EMPLOYEE ID', _employeeID, TextInputType.emailAddress, false),
          InputTextbox('PASSWORD', _password, TextInputType.text, true),
          SizedBox(
            height: 30,
          ),
          SubmitButton('SIGN IN', () async {
            var map = new Map<String, dynamic>();

            map['password'] = _password.text;
            map['employeeID'] = _employeeID.text;
            var res = await loginPost(map);

            if (res != null) {
              if (res.success) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var token = res.about['data']['token'];
                var name = res.about['comment'].toString();
                // print(token);
                prefs.setString('E_TOKEN', token);
                prefs.setString('__EID', res.about['comment'].toString());
                prefs.setString('__ENAME', name);

                if (res.about['check']) {
                  Navigator.pushNamed(context, '/livebus', arguments: name);
                } else {
                  Navigator.pushNamed(context, '/home', arguments: name);
                }
              } else {
                await showAlertBox(context, "Unsuccessful Login",
                    "Oops..Login Failed..! Try Again");
              }
            } else {
              await showAlertBox(
                  context, "ERROR", "Something went wrong..! Please try Again");
            }
          }),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to the community ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
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
