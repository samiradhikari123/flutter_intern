import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socioapp/mainscreen/cubit/bottomnavbar_cubit.dart';
import 'package:socioapp/mainscreen/dashboard.dart';

import 'package:socioapp/auth/login.dart';

void main() async {
  // runApp(const SocioApp());
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');

  runApp(BlocProvider<BottomnavbarCubit>(
    create: (context) => BottomnavbarCubit(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userid == null ? const SocioApp() : const Dashboard(),
    ),
  ));
}

class SocioApp extends StatelessWidget {
  const SocioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Nepal's Socio App",
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
