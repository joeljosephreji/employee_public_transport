import 'package:employee_public_transport/screens/auth/confirm.dart';
import 'package:employee_public_transport/screens/auth/forgot_password.dart';
import 'package:employee_public_transport/screens/auth/login.dart';
import 'package:employee_public_transport/screens/auth/registration.dart';
import 'package:employee_public_transport/screens/home.dart';
import 'package:employee_public_transport/screens/livebus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('__EID');
  var ch = prefs.getBool('__CHECK');
  print("IDDD");
  print(id);
  print(ch);
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Montserrat', primaryColor: Colors.green),
    home: id == null ? Login() : (ch == null ? EmployeeHome() : LiveBus()),
    // home: Login(),
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
      '/livebus': (context) => LiveBus(),
    },
  ));
}
