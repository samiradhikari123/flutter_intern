import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:socioapp/model/usermodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Usermodel> profileList = [];
  Usermodel? loginUsers;

  Future<void> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          profileList = decodedData.map((e) => Usermodel.fromJson(e)).toList();
        });
      } catch (e) {
        print("error occurred $e");
      }
    } else {
      profileList = [];
    }
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userid');

    if (userIdData != null) {
      try {
        loginUsers = profileList
            .firstWhere((user) => user.userid.toString() == userIdData);
        print(loginUsers?.fullname);
      } catch (e) {
        print(e);
      }
    } else {
      loginUsers = null;
      print("User not found");
    }
  }

  @override
  void initState() {
    super.initState();
    getAllUserData();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile Screen',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 235, 130, 130),
              ),
              const SizedBox(height: 7),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: loginUsers?.coverpic != null
                        ? Image.file(
                            loginUsers!.coverpic,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const Text('No cover picture'),
                  ),
                  Positioned(
                    top: 140,
                    left: MediaQuery.of(context).size.width / 2 - 80,
                    child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: loginUsers?.profilepic != null &&
                                  // ignore: unrelated_type_equality_checks
                                  loginUsers!.profilepic != ""
                              ? CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(loginUsers!.profilepic),
                                )
                              : const Text('No Image'),
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              loginUsers != null &&
                      loginUsers!.fullname != null &&
                      loginUsers!.fullname != ""
                  ? Text(
                      '${loginUsers!.fullname}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    )
                  : const Text('No Name'),
              loginUsers != null &&
                      loginUsers!.email != null &&
                      loginUsers!.email != ""
                  ? Text(
                      '${loginUsers!.email}',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    )
                  : const Text('No Email'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text("Add to story"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text("Edit Profile"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 235, 130, 130),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About User",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Contact info:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 223, 218, 218),
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      loginUsers?.mobilenumber ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Mobile Number"),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Basic Info:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 223, 218, 218),
                      child: Icon(Icons.person_2_outlined),
                    ),
                    title: Text(
                      loginUsers?.gender ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Gender"),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Date of Birth:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 223, 218, 218),
                      child: Icon(Icons.cake),
                    ),
                    title: Text(
                      loginUsers?.dateofbirth ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Date of Birth"),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Relationship:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 223, 218, 218),
                      child: Icon(Icons.favorite_border),
                    ),
                    title: Text(
                      loginUsers?.maritalstatus ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Marital Status"),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Work:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 223, 218, 218),
                      child: Icon(Icons.work_history_rounded),
                    ),
                    title: Text(
                      'Add Work Experience',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Work Experience"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
