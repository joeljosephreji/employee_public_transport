import 'dart:convert';

import 'package:employee_public_transport/templates/alert_box.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:employee_public_transport/templates/io_classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader("Header"),
          //******************************END TRIP******************************
          createDrawerItem(
              icon: Icons.directions_bus,
              text: 'End Trip',
              onTap: () async {
                return showDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text('CONFIRMATION',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 16)),
                      content: new Text(
                        'Are you sure that you want to end the trip ?',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('YES'),
                          onPressed: () {
                            confirmEndTrip(context);
                          },
                        ),
                        FlatButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
              }),
          //******************************LOG OUT******************************
          createDrawerItem(
              icon: Icons.phonelink_erase,
              text: 'Logout',
              onTap: () async {
                return showDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text('CONFIRMATION',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      content: new Text(
                        'Are you sure that you want to logout ?',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('YES'),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('__UID');
                            prefs.remove('__UNAME');

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (route) => false);
                          },
                        ),
                        FlatButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
              })
        ],
      ),
    );
  }
}

Widget createDrawerHeader(String text) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green[700], Colors.green[400]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/lights.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

Future<dynamic> endTrip(Map<String, dynamic> map, String _token) async {
  try {
    String url = Env.get().ip;
    url = url + '/private/employee/endTrip';

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

Future confirmEndTrip(BuildContext context) async {
  var map = new Map<String, dynamic>();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('__CHECK');
  map['employeeCode'] = prefs.getString('__EID');
  String _token = prefs.getString('E_TOKEN');

  var res = await endTrip(map, _token);
  print(res.about);
  if (res != null) {
    if (res.success) {
      //SUCCESS
      await showAlertBox(context, 'SUCCESS', res.about['comment']);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      //SOME PROBLEM WHILE PROCESSING
      await showAlertBox(context, 'ERROR', res.about['comment']);
    }
  } else {
    await showAlertBox(context, 'CONNECTION ERROR',
        'Something went wrong with the connection..! Please try again..!');
  }
}
