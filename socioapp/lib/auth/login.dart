import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socioapp/mainscreen/dashboard.dart';

import 'package:socioapp/auth/signup.dart';

import 'package:socioapp/model/usermodel.dart';

List<Usermodel> user = [];

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isVisible = true;
  bool value = false;

  Future<void> fetchuserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('dataList');
      if (jsonData == null) {
        String? jsonData = await rootBundle.loadString("assets/users.json");
        final jsonList = json.decode(jsonData);
        // print(jsonList);
        if (jsonList is List<dynamic>) {
          user = jsonList.map((json) => Usermodel.fromJson(json)).toList();
        } else if (jsonList is Map<String, dynamic>) {
          user.add(Usermodel.fromJson(jsonList));
        }
        List<Map<String, dynamic>> jsonDatalist =
            user.map((cv) => cv.toJson()).toList();
        String jsonDataString = json.encode(jsonDatalist);
        sharedPreferences.setString("dataList", jsonDataString);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    print("aaa${jsonData}");
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        setState(() {
          user = decodedData.map((e) => Usermodel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      user = [];
    }
    return [];
  }

  bool isValidemail(String input) {
    final emailRegExp = RegExp(r'\S+@\S+\.\S+');
    return emailRegExp.hasMatch(input);
  }

  Future<void> _loginuser(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // ignore: unused_local_variable
      Usermodel users = user.firstWhere(
          (user) => user.email == email && user.password == password);
      prefs.setString('userid', users.userid.toString());

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'Login Sucessfully',
        )),
        backgroundColor: Color.fromARGB(255, 84, 163, 248),
      ));

      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Email or Password Incorrect')),
        backgroundColor: Color.fromARGB(255, 188, 6, 103),
      ));
      return;
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
    fetchuserData();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 246, 248, 249),
                      ),
                      height: 150,
                      width: double.infinity,
                      child: const Text(
                        'Login Form',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 30, 225),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.person_3_rounded,
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your email";
                        }
                        return null;
                      },
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(fontSize: 16),
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your password";
                        }
                        return null;
                      },
                      obscureText: _isVisible,
                      controller: password,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          labelText: 'Password',
                          labelStyle: const TextStyle(fontSize: 16),
                          hintText: '*******',
                          disabledBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 100),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //  setState(() {
                              _loginuser(email.text, password.text);
                              //}
                              // ),
                            }
                          },
                          child: const Text('LogIn'),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password'))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("If you don't have an account,please:"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text("SignUp")),
                      ],
                    )
                  ]),
            )));
  }
}
