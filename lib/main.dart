import 'package:flutter/material.dart';
import 'style.dart';
import 'screens/registration/registration.dart';

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
      home: Registration(),
      debugShowCheckedModeBanner: false,
    );
  }
}
