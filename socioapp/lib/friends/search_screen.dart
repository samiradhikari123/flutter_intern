import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socioapp/friends/friend_details.dart';
import 'package:socioapp/mainscreen/homescreeen.dart';

import 'package:socioapp/model/usermodel.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Usermodel> matchQuery = profileList.where((user) {
      return user.fullname!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileID', result.userid.toString());
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FriendDetails()));
          },
          child: Card(
            color: const Color.fromARGB(255, 160, 210, 252),
            child: ListTile(
              title: Text('${result.fullname}'),
              leading: ClipOval(
                  child: result.profilepic.path == ""
                      ? Image(
                          height: 50,
                          width: 50,
                          image: FileImage(result.profilepic),
                          fit: BoxFit.cover,
                        )
                      : const Text('No image')),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Usermodel> matchQuery = profileList.where((user) {
      return user.fullname!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileID', result.userid.toString());
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FriendDetails()));
          },
          child: Card(
            color: const Color.fromARGB(255, 160, 210, 252),
            child: ListTile(
              title: Text('${result.fullname}'),
              leading: ClipOval(
                  child: result.profilepic.path == ""
                      ? Image(
                          height: 50,
                          width: 50,
                          image: FileImage(result.profilepic),
                          fit: BoxFit.cover,
                        )
                      : const Text('No image')),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }
}
