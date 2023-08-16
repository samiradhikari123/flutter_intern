import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socioapp/mainscreen/dashboard.dart';
import 'package:socioapp/mainscreen/homescreeen.dart';
import 'package:socioapp/model/user_fromjson.dart';
import 'package:socioapp/model/userfriendlistmodel.dart';
import 'package:socioapp/model/usermodel.dart';
import 'package:uuid/uuid.dart';

class FriendDetails extends StatefulWidget {
  const FriendDetails({super.key});

  @override
  State<FriendDetails> createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  Usermodel? friendId;
  Usermodel? loginUsers;

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIddata = prefs.getString('profileId');

    if (userIddata != null) {
      try {
        friendId = profileList.firstWhere((user) => user.userid == userIddata);
        print('=========friend id: ${friendId?.fullname}');
      } catch (e) {
        print(e);
      }
    } else {
      friendId;
    }
    return [];
  }

  Future<void> sendRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    requestAcceptorCancle.add(UserFriendListModel(
        user_list_id: const Uuid().v4(),
        userId: loginUsers!.userid.toString(),
        friendId: friendId!.userid.toString(),
        requestedBy: loginUsers!.userid.toString(),
        postedat: DateTime.now().toString(),
        hasNewRequest: true,
        hasNewRequestAccepted: false,
        hasRemoved: false));

    List<Map<String, dynamic>> jsonDataList =
        requestAcceptorCancle.map((add) => add.toJson()).toList();

    String jsonData = json.encode(jsonDataList);
    print('=====new data $jsonData');

    prefs.setString('request', jsonData);
    getUserId();
  }

  var indexOfIt;

  List<UserFriendListModel> request = [];
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('request');
    //  print(jsonData);

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          request =
              decodedData.map((e) => UserFriendListModel.fromJson(e)).toList();
        });
        indexOfIt = request.indexWhere((e) =>
            e.friendId == friendId!.userid &&
            e.requestedBy == loginUsers!.userid &&
            e.userId == loginUsers!.userid);
      } catch (e) {
        rethrow;
      }
    } else {
      request = [];
    }
    return [];
  }

  Future<void> compare() async {
    try {
      indexOfIt = request.indexWhere((e) =>
          e.friendId == friendId!.userid &&
          e.requestedBy == loginUsers!.userid &&
          e.userId == loginUsers!.userid);
      setState(() async {
        if (indexOfIt != -1) {
          requestAcceptorCancle.removeAt(indexOfIt);
          String update = jsonEncode(requestAcceptorCancle);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('request', update);

          getUserData();
        } else {
          print('No Data');
          getUserData();
        }
      });
    } catch (e) {
      return;
    }
    setState(() {});
  }

  void all() async {
    await getUserId();
    await getUserData();
    //compare();
  }

  @override
  void initState() {
    all();
    super.initState();
  }

  bool newRequest = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  // clipper: CurveClipper(),
                  child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: friendId?.profilepic.path != ""
                          ? Image(
                              image: FileImage(friendId!.profilepic),
                              fit: BoxFit.cover,
                            )
                          : Image(
                              image: AssetImage('${friendId!.profilepic}'),
                              fit: BoxFit.cover,
                            )),
                ),
                Positioned(
                    top: 15,
                    left: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ))),
                Positioned(
                  left: 120,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 6.0, color: Colors.white),
                    ),
                    child: ClipOval(
                        child: friendId?.profilepic.path != ""
                            ? Image(
                                height: 100,
                                width: 100,
                                image: FileImage(friendId!.profilepic),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('${friendId!.profilepic}'),
                                fit: BoxFit.cover,
                              )),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.amber,
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  friendId?.fullname != ""
                      ? Text(' Name: ${friendId!.fullname}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))
                      : const Text('No Name'),
                  const SizedBox(height: 8),
                  friendId?.email != ""
                      ? Text(
                          ' Email: ${friendId!.email}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : const Text('No Email'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            indexOfIt != null ? compare() : sendRequest();
                          },
                          child: Row(
                            children: [
                              Icon(indexOfIt != null
                                  ? Icons.cancel
                                  : Icons.person_add_alt_1),
                              const SizedBox(width: 8),

                              // ? Text('Cancle Request')
                              Text(indexOfIt != null
                                  ? 'Cancle Request'
                                  : 'Add friend')
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              compare();
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.messenger_outline_outlined),
                              SizedBox(width: 8),
                              Text('Message')
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Contract info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      '${friendId!.mobilenumber}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Mobile'),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Basic info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person_2_outlined),
                    ),
                    title: Text(
                      '${friendId!.gender}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Gender'),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.cake),
                    ),
                    title: Text(
                      '${friendId!.dateofbirth}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Birthday'),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Relationship',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.favorite_border),
                    ),
                    title: Text(
                      '${friendId!.maritalstatus}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Work',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.work_history_outlined),
                    ),
                    title: Text(
                      'Add Work Experience',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
