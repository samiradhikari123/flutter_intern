import 'package:flutter/material.dart';

Widget textForm({required String labelText, required String hint}) {
  return TextField(
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.teal, fontSize: 18),
        hintText: hint,
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        )),
  );
}
