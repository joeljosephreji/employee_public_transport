import 'dart:convert';

import 'package:employee_public_transport/templates/alert_box.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';
import 'package:employee_public_transport/templates/io_classes.dart';
import 'package:employee_public_transport/templates/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController otp = new TextEditingController();

    return Scaffold(
        appBar: AppBar(title: Text('Confirm')),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Enter the otp sent to your mail-ID for confirming your registration..!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              InputTextbox('OTP', otp, TextInputType.text, false),
              SizedBox(height: 40.0),
              SubmitButton(
                'VERIFY',
                () async {
                  dynamic id = ModalRoute.of(context).settings.arguments;
                  print(id['data']);
                  DateTime timestamp = new DateTime.now();
                  // print(timestamp);
                  var map = new Map<String, dynamic>();
                  map['otp'] = otp.text;
                  map['timestamp'] = timestamp.toIso8601String();
                  map['employee_id'] = id['data'].toString();
                  var res = await verifyPost(map);

                  if (res != null) {
                    print(res.about);
                    print("xxx");
                    if (res.success) {
                      await showAlertBox(context, "SUCCESS :D",
                          'Press OK to move onto the LoginPage..!');

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login', (route) => false);
                    } else {
                      await showAlertBox(
                          context, "VERIFICATION FAILED", res.about['comment']);
                    }
                  } else {
                    await showAlertBox(context, "CONNECTION FAILED",
                        "Could'nt connect to the server:/");
                  }
                },
              ),
            ],
          ),
        ));
  }
}

Future<dynamic> verifyPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/employee/verify';

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    print(statusCode);
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
