import 'package:employee_public_transport/screens/drawer/app_drawer.dart';
import 'package:employee_public_transport/screens/get_data/post.dart';
import 'package:employee_public_transport/templates/env.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveBus extends StatefulWidget {
  @override
  _LiveBusState createState() => _LiveBusState();
}

class _LiveBusState extends State<LiveBus> {
  var _routeID;
  List _pointData;
  var _pointLen;
  var _roomID;

  IO.Socket _socket;

  Location location;
  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;
  // a reference to the destination location
  LocationData destinationLocation;

  Future getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _routeID = prefs.getString('__RID');
    _roomID = 'B' + _routeID;
  }

  void getBusStopPoints() async {
    try {
      await getLocalData();
      print(_routeID);

      var map = new Map<String, dynamic>();
      map['route_id'] = _routeID;

      String url = '/private/user/requestbus/getAllStopLocationsByID';
      var res = await postWithBodyOnly(map, url);
      // print(res.about);

      if (res.success) {
        _pointData = res.about['data'];
      }
    } catch (err) {
      print(err);
    }
  }

  void socketInit() {
    String url = Env.get().ip;
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket']
    });
    // _socket.on('connect', (_) {
    //   print('Inside Connection');
    //   _socket.emitWithAck('employeeCreatesRoom', _roomID, ack: (data) {
    //     if (data != null) {
    //       print('from server $data');
    //     } else {
    //       print("Null");
    //     }
    //   });
    // });
  }

  void getMyLocation() async {
    currentLocation = await location.getLocation();
  }

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    // getMyLocation();
    getBusStopPoints();
    socketInit();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      _socket.on('connect', (_) {
        _socket.emitWithAck('employeeSendsData', {
          'room': _roomID,
          'data': {'latitude': cLoc.latitude, 'longitude': cLoc.longitude}
        }, ack: (data) {
          if (data != null) {
            print('Room connection Message: $data');
          } else {
            print("Null");
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "HERE WE GOO..!",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
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

  // void updatePinOnMap() async {}
}
