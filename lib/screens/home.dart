import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments;
    if (data == null) {
      data = 'BeastMaster64';
    }
    print(data);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Hello ' + data + ' !'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('__UID');
              prefs.remove('__UNAME');

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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: showHomePage()),
    );
  }
}

List<Widget> showHomePage() {
  return [
    SizedBox(height: 40.0),
  ];
}

Future<dynamic> getBusData(Map<String, dynamic> map) async {
  try {} catch (err) {
    print(err);
    return null;
  }
}
