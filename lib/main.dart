import 'package:ecommerce_app/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/home/home_page.dart';
import 'package:ecommerce_app/login/bloc/login_bloc.dart';
import 'package:ecommerce_app/login/ui/login_screen.dart';
import 'package:ecommerce_app/order/bloc/order_bloc.dart';
import 'package:ecommerce_app/search/bloc/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SearchBloc(),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => OrderBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'OpenSans'),
          home: token == null ? LoginScreen() : Home(),
        )),
  );
}
