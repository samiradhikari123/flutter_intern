import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socioapp/auth/login.dart';
import '../model/usermodel.dart';

import 'package:uuid/uuid.dart';

Map<String, dynamic> signUpEmptyList = {};
Map<String, dynamic> loginEmptyList = {};

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

// Future<void> savecoverpicture(String photoPath) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('cover_picture', photoPath);
// }

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  File? coverimage;
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  bool _isVisible = false;

  final ImagePicker picker = ImagePicker();

  Future takephoto(ImageSource source) async {
    try {
      final pickedProfile = await picker.pickImage(source: source);
      if (pickedProfile == null) return;
      String imagePath = pickedProfile.path;
      File? img = File(imagePath);
      setState(() {
        image = img;
        Navigator.of(context).pop();
      });
    } catch (e) {
      //rethrow;
      Navigator.of(context).pop();
    }
  }

  Future takecoverphoto() async {
    try {
      final pickedcover = await picker.pickImage(source: ImageSource.gallery);
      if (pickedcover == null) return;
      String coverimagepath = pickedcover.path;
      File? coverima = File(coverimagepath);
      setState(() {
        coverimage = coverima;
      });
    } catch (e) {
      //rethrow;
    }
  }

  Future<void> signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    print('Raj${jsonString}');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          signuplist =
              jsonData.map((json) => Usermodel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          loginEmptyList
              .addAll(Usermodel.fromJson(jsonData) as Map<String, dynamic>);
        }
      } catch (e) {
        print(e);
      }
    }

    signuplist.add(Usermodel(
        coverpic: coverimage!,
        profilepic: image!,
        fullname: fullname.text,
        userid: const Uuid().v4().toString(),
        email: email.text,
        password: passwordController.text,
        mobilenumber: mobilenumber.text,
        dateofbirth: dateofbirth.text,
        gender: gender,
        maritalstatus: selectValue));

    List<Map<String, dynamic>> jsonDataList =
        signuplist.map((cv) => cv.toJson()).toList();
    loginEmptyList[email.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  String gender = '';

  String selectValue = "Married";
  List<String> dropdownItem = ["Married", "Unmarried"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SignUpForm"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Select profile picture:",
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),

                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 164, 150, 245)),
                        child: Center(
                          child: image == null
                              ? const Text('No Image selected')
                              : CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 135, 172, 236),
                                  radius: 60,
                                  backgroundImage: FileImage(image!),
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 35,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor:
                                      const Color.fromARGB(255, 130, 168, 234),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  context: context,
                                  builder: (context) => buttonSheet());
                            },
                            icon: const Icon(Icons.camera_alt),
                          )),
                    ],
                  ),

                  const Divider(
                    thickness: 2,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 10),
                  const Text("Select Cover Picture:"),

                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                          height: 100,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromARGB(255, 96, 169, 230)),
                          child: Center(
                              child: coverimage == null
                                  ? const Text('No Image selected')
                                  : Image.file(
                                      coverimage!,
                                      height: 100,
                                      width: 300,
                                      fit: BoxFit.cover,
                                    ))),
                      Positioned(
                          bottom: 1,
                          right: 125,
                          child: IconButton(
                            onPressed: () {
                              takecoverphoto();
                            },
                            icon: const Icon(Icons.camera_alt),
                          ))
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.amber,
                  ),
                  // buttonSheet(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Add your details here:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 20)),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (text) {
                      final regex =
                          RegExp(r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$');
                      if (text == null || text.isEmpty) {
                        return "should not be empty";
                      } else if (!regex.hasMatch(text)) {
                        return "accepts only character";
                      }
                      return null;
                    },
                    controller: fullname,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(fontSize: 16),
                      hintText: 'Enter your fullname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (text) {
                      final regex = RegExp(r'\S+@\S+\.\S+');
                      if (text == null || text.isEmpty) {
                        return "should not be empty";
                      } else if (text.length > 15) {
                        return 'Length size=15';
                      } else if (!regex.hasMatch(text)) {
                        return "enter a valid mail";
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
                    validator: (text) {
                      final regex =
                          RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
                      if (text == null || text.isEmpty) {
                        return "should not be empty";
                      } else if (!regex.hasMatch(text)) {
                        return "password must contain special character,numbers and capital and small letter";
                      }
                      return null;
                    },
                    obscureText: _isVisible,
                    controller: passwordController,
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
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
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
                  TextFormField(
                    validator: (value) {
                      RegExp regExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value)) {
                        return "Please enter valid phone number";
                      }
                      return null;
                    },
                    controller: mobilenumber,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: const TextStyle(fontSize: 16),
                      hintText: '+977**********',
                      prefixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      RegExp(r'^(0[1-9]|1[0-9]|2[0-9]|3[01])-/. -/. $');
                      if (value!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: dateofbirth,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Select Date of Birth"),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2024));
                      if (pickeddate != null) {
                        setState(() {
                          dateofbirth.text =
                              DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                  Row(
                    children: [
                      const Text('Gender'),
                      Radio(
                          value: 'Male',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          }),
                      const Text('Male'),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      Radio(
                          value: 'Female',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          }),
                      const Text('Female'),
                      const SizedBox(height: 20),
                      Radio(
                          value: 'Others',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          }),
                      const Text('Others'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Marital Status"),
                      const SizedBox(width: 30),
                      DropdownButton<String>(
                        focusColor: Colors.brown,
                        value: selectValue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.indigo,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectValue = newValue!;
                          });
                        },
                        items: dropdownItem.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // setState(() {
                          //   signUp();
                          // });
                          setState(() {
                            try {
                              // ignore: unused_local_variable
                              Usermodel user = signuplist.firstWhere(
                                  (user) => user.email == email.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Center(child: Text('Email already in use')),
                                backgroundColor:
                                    Color.fromARGB(255, 100, 59, 215),
                              ));

                              return;
                            } catch (e) {
                              signUp();
                              return;
                            }
                          });
                        }
                      },
                      child: const Text("Signup Form")),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account :",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("LogIn")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buttonSheet() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const Text('Choose Profile photo'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera),
              const SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                    takephoto(ImageSource.camera);
                  },
                  child: const Text('Camera')),
              const SizedBox(width: 20),
              const Icon(Icons.photo),
              const SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                    takephoto(ImageSource.gallery);
                  },
                  child: const Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }
}
