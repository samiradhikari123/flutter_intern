import 'dart:async';
import 'package:flutter/material.dart';

import 'package:socioapp/mainscreen/dashboard.dart';
import 'package:socioapp/auth/login.dart';

import 'authhelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // await AuthHelper.isUserLoggedIn()== true? ;
    Timer(
        const Duration(seconds: 5),
        () => AuthHelper.isUserLoggedIn() == true
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Dashboard()))
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 137, 225),
      body: Center(
        child: Image.asset('assets/image/pic2.webp'),
        //  CircleAvatar(
        //   radius: 80,
        //   backgroundImage: AssetImage('assets/logo1.jpg'),
        // ),
      ),
    );
  }
}
//Image.asset('assets/logo.png'),
