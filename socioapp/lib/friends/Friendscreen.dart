import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socioapp/friends/search_screen.dart';
import 'package:socioapp/mainscreen/homescreeen.dart';
import 'package:socioapp/model/userfriendlistmodel.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<UserFriendListModel> request = [];
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('request');

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          request =
              decodedData.map((e) => UserFriendListModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      request = [];
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    // addToList();
  }

  List<UserFriendListModel>? listIndex;
  Future<void> addToList() async {
    setState(() {
      listIndex = request.firstWhere((list) => list.user_list_id == profileList)
          as List<UserFriendListModel>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Friends",
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 235, 130, 130),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  child: const Row(
                    children: [Icon(Icons.search), Text('Search....')],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Friend Requests', style: TextStyle(fontSize: 20)),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View all',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: const ClipOval(
                            child: Image(
                              height: 90,
                              width: 90,
                              image: NetworkImage(
                                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwebneel.com%2Fdaily%2Fsites%2Fdefault%2Ffiles%2Fimages%2Fdaily%2F07-2019%2F2-creative-photography-ideas-walled-brandon-woelfel.jpg&f=1&nofb=1&ipt=9fbe48993c17e34653c29a68d5d8f7ea10486a27f5300d200279ab2d80f98d6d&ipo=images'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Samir Adhikari',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Confirm'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Delete'),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
