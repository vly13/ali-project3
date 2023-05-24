import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:project2/Screens/Auth.dart';
import 'package:project2/Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project2/Screens/SignUpScreen.dart';
import 'package:project2/Screens/NoInternet.dart';
import 'package:project2/Screens/page1.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Location location = new Location();
  // bool ison = await location.serviceEnabled();
  // if(ison){
  //   bool isturnedon = await location.requestService();
  //   if (isturnedon){
  //     print("GPS is turned ON");
  //   }else{
  //     print("GPS is turned OFF");
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      routes: {
        '/': (context) => const Auth(),
        'signupScreen': (context) => const SignupScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'homeScreen': (context) => HomeScreen(),
      },
    );
  }
}
