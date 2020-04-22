import 'dart:convert';

import 'package:employee_public_transport/templates/alert_box.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:employee_public_transport/templates/input_textbox.dart';
import 'package:employee_public_transport/templates/io_classes.dart';
import 'package:employee_public_transport/templates/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _busNo = new TextEditingController();
TextEditingController _regNo = new TextEditingController();
TextEditingController _busMake = new TextEditingController();
TextEditingController _routeNo = new TextEditingController();
TextEditingController _employeeCode = new TextEditingController();

class EmployeeHome extends StatefulWidget {
  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  String _token;
  void getAllSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('E_TOKEN');
  }

  @override
  void initState() {
    getAllSavedData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('__EID');
              prefs.remove('__ENAME');

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: Icon(Icons.phonelink_erase),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
        children: <Widget>[
          Center(
            child: Text(
              "LET'S START THE BUS..!",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputTextbox('BUS NUMBER', _busNo, TextInputType.text, false),
          InputTextbox('REGISTER NUMBER', _regNo, TextInputType.text, false),
          InputTextbox('BUS MAKE', _busMake, TextInputType.text, false),
          InputTextbox('EMPLOYEE ID', _employeeCode, TextInputType.text, false),
          InputTextbox('ROUTE ID', _routeNo, TextInputType.text, false),
          SizedBox(
            height: 25,
          ),
          SubmitButton('START', () async {
            var map = new Map<String, dynamic>();

            // map['busNo'] = _busNo.text;
            // map['regNo'] = _regNo.text;
            // map['busMake'] = _busMake.text;
            // map['employeeCode'] = _employeeCode.text;
            // map['routeNo'] = _routeNo.text;
            map['busNo'] = "100D";
            map['regNo'] = "120090";
            map['busMake'] = "TATA";
            map['employeeCode'] = "007";
            map['routeNo'] = "0101-32";

            var res = await startBus(map);
            print(res.about);
            if (res != null) {
              if (res.success) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('__CHECK', true);
                await showAlertBox(context, 'SUCCESS',
                    'Successfully added to live buses..:) Press OK to continue..!');
                Navigator.pushNamed(context, '/livebus',
                    arguments: res.about['data']);

                //GOTO PAGE
              } else {
                //SOME PROBLEM WHILE PROCESSING
                await showAlertBox(context, 'ERROR', res.about['comment']);
              }
            } else {
              await showAlertBox(context, 'CONNECTION ERROR',
                  'Something went wrong with the connection..! Please try again..!');
            }
          })
        ],
      ),
    );
  }

  Future<dynamic> startBus(Map<String, dynamic> map) async {
    try {
      String url = Env.get().ip;
      url = url + '/private/employee/startTrip';

      http.Response response = await http.post(url, body: map, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'x-access-token': _token
      });
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
}
