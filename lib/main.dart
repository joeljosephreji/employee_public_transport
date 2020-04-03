import 'package:employee_public_transport/screens/confirm.dart';
import 'package:employee_public_transport/screens/forgot_password.dart';
import 'package:employee_public_transport/screens/home.dart';
import 'package:employee_public_transport/screens/login.dart';
import 'package:employee_public_transport/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('__EID');
  print("IDDD");
  print(id);
  runApp(MaterialApp(
    home: id == null ? Login() : EmployeeHome(),
    // home: LoginPage(),
    // home: ConfirmPage(),
    // home: SignUp(),
    // home: id == null ? UserHome() : LoginPage(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/signup': (context) => new Registration(),
      '/login': (context) => new Login(),
      '/home': (context) => new EmployeeHome(),
      '/forgotpass': (context) => new ForgotPassword(),
      '/confirmpage': (context) => ConfirmPage(),
    },
  ));
}
