import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socioapp/mainscreen/dashboard.dart';

import 'package:socioapp/model/usermodel.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  File? photo;
  String? userid;
  String? postid;
  String? postedat;

  String? description;
  List<String> postlikedby;

  PostModel({
    this.photo,
    required this.userid,
    required this.postid,
    required this.postedat,
    required this.description,
    required this.postlikedby,
  });
  Map<String, dynamic> toJson() {
    String photoPath = photo != null ? photo!.path : "";
    return {
      'photo': photoPath,
      'userid': userid,
      'postid': postid,
      'postedat': postedat,
      'description': description,
      'postlikedby': postlikedby,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    String photopath = json['photo'] ?? "";
    return PostModel(
        photo: File(photopath),
        userid: json['userid'],
        postid: json['postid'],
        postedat: json['postedat'],
        description: json['description'],
        postlikedby: List<String>.from(json['postlikedby']));
  }
}

List<PostModel> postList = [];

class AddPost extends StatefulWidget {
  final Usermodel? loginUsers;
  const AddPost({Key? key, required this.loginUsers}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? postImage;
  List<PostModel> post = [];
  Usermodel? loginUsers;
  final ImagePicker picker = ImagePicker();

  Future takephoto() async {
    try {
      final pickedphoto = await picker.pickImage(source: ImageSource.gallery);
      if (pickedphoto == null) return;
      String photopath = pickedphoto.path;
      File? photo = File(photopath);
      setState(() {
        postImage = photo;
      });
    } catch (e) {
      //rethrow;
    }
  }

  // Map<String, dynamic> profileEmptyList = {};
  void postDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('profileData');
    print(jsonString);
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          post = jsonData.map((json) => PostModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          post.add(PostModel.fromJson(jsonData));
        }
      } catch (e) {
        print("Error decoding JSON data: $e");
      }
    }

    print("Adding new post");
    post.add(PostModel(
        photo: postImage,
        userid: widget.loginUsers!.userid,
        postid: const Uuid().v4(),
        description: descController.text,
        postedat: DateTime.now().toString(),
        postlikedby: []));

    List<Map<String, dynamic>> profileDataList =
        post.map((e) => e.toJson()).toList();
    String? profileData = jsonEncode(profileDataList);
    print('profileData: $profileData');
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('profileData', profileData);
  }

  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create a Post",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  postDetails();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                });
              },
              child: const Text("POST"))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            takephoto();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add a photo')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 235, 130, 130),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Add your Post :",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Decsription',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                hintText: 'Write about sth....',
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 160, 210, 252)),
              child: Center(
                  child: postImage == null
                      ? const Text(
                          "Add Image",
                          style: TextStyle(fontSize: 20),
                        )
                      : Image(
                          height: 300,
                          width: double.infinity,
                          image: FileImage(postImage!),
                          fit: BoxFit.cover,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
