import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  File? image;
  Future pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
    InkWell(
        onTap: pickImage,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 40.0,
          child: CircleAvatar(
            radius: 38.0,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset('images/newimage.png'),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(),
              MaterialButton(
                  color: const Color.fromARGB(255, 155, 163, 211),
                  child: const Text(
                    "Choose Image",
                  ),
                  onPressed: () {
                    pickImage();
                  }),
            ],
          ),
          image == null ? const Text("Pick an image") : Image.file(image!),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
