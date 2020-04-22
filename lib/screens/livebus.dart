import 'package:employee_public_transport/screens/drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class LiveBus extends StatefulWidget {
  @override
  _LiveBusState createState() => _LiveBusState();
}

class _LiveBusState extends State<LiveBus> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "HERE WE GOO..!",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              'assets/images/travel2.png',
              color: Colors.teal[800],
            ),
          )
        ],
      ),
    );
  }
}