import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socioapp/auth/login.dart';

import 'package:socioapp/mainscreen/post.dart';

import 'package:socioapp/model/usermodel.dart';

import '../friends/friend_details.dart';

List<Usermodel> profileList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> userPostData = [];
  Usermodel? loginUsers;
  Usermodel? postIdDetails;

  @override
  void initState() {
    super.initState();

    initializeData();
  }

  Future<void> initializeData() async {
    await getAllUserData();
    await getUserId();
    await getProfileData();
  }

  Future<void> getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? profileString = pref.getString('profileData');
    print('========$profileString');
    if (profileString != null) {
      try {
        final decodeprofileData = json.decode(profileString) as List<dynamic>;
        setState(() {
          userPostData =
              decodeprofileData.map((e) => PostModel.fromJson(e)).toList();
        });
      } catch (e) {
        print("Error decoding user data: $e");
      }
    } else {
      userPostData = [];
    }
  }

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
        print("error decoding user data: $e");
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
        loginUsers = profileList.firstWhere(
          (user) => user.userid.toString() == userIdData,
        );
        // print(loginUsers?.fullname);
      } catch (e) {
        print("Error getting user by ID: $e");
      }
    } else {
      loginUsers = null;
      print("User not found");
    }
  }

  void toggleLike(String postId) {
    setState(() {
      final postIndex =
          userPostData.indexWhere((post) => post.postid == postId);
      if (postIndex != -1) {
        if (userPostData[postIndex].postlikedby.contains(loginUsers!.userid)) {
          userPostData[postIndex].postlikedby.remove(loginUsers!.userid);
        } else {
          userPostData[postIndex]
              .postlikedby
              .add(loginUsers!.userid.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Homepage",
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userid');

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                      child: Text(
                    'LoggedOut Sucessfully',
                  )),
                  backgroundColor: Color.fromARGB(255, 84, 163, 248),
                ));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 235, 130, 130),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (loginUsers?.fullname != null &&
                      loginUsers!.fullname != "")
                    Text(
                      "Welcome \n Back: \n ${loginUsers!.fullname} ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue),
                    )
                  else
                    const Text('Hello'),
                  const SizedBox(
                    width: 80,
                  ),
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: loginUsers?.profilepic != null &&
                                // ignore: unrelated_type_equality_checks
                                loginUsers!.profilepic != ""
                            ? CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 30,
                                backgroundImage:
                                    FileImage(loginUsers!.profilepic),
                              )
                            : const Text('No Image'),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPost(
                        loginUsers: loginUsers,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 243, 143, 143)),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Add to your Post",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userPostData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = userPostData[index];
                    postIdDetails = profileList
                        .firstWhere((user) => user.userid == data.userid);
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: const Color.fromARGB(255, 160, 210, 252),
                        color: const Color.fromARGB(255, 160, 210, 252),
                        elevation: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('profileData',
                                            data.userid.toString());
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FriendDetails()));
                                      },
                                      child: ClipOval(
                                        child: loginUsers?.profilepic != null &&
                                                loginUsers!
                                                    .profilepic.path.isNotEmpty
                                            ? Image(
                                                height: 40,
                                                width: 40,
                                                image: FileImage(
                                                    loginUsers!.profilepic),
                                                fit: BoxFit.cover,
                                              )
                                            : const Text('No Image'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${postIdDetails!.fullname}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('${data.postedat}',
                                          style: const TextStyle(fontSize: 14))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (data.description != "")
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${data.description}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              )
                            else
                              const Text(""),
                            Container(
                              height: 350,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: data.photo != null
                                    ? DecorationImage(
                                        image: FileImage(data.photo!),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      toggleLike(data.postid.toString());
                                    },
                                    icon: data.postlikedby
                                            .contains(loginUsers!.userid)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.brown,
                                          )
                                        : const Icon(Icons.favorite_border)),
                                Text('${data.postlikedby.length}'),
                                const SizedBox(width: 5),
                                const Text('Like')
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
