import 'package:employee_public_transport/screens/login/login.dart';
import 'package:employee_public_transport/screens/registration/registration.dart';
import 'package:flutter/material.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Monserrat',
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(title: AppBarTextStyle),
        ),
      ),
      home: Login(),
      routes: {
        '/signup': (context) => new Registration(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
