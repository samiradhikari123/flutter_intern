import 'package:flutter/material.dart';
import 'package:intern1/edudetails.dart';

import 'package:intl/intl.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  String valueChoose = 'SEE';
  List<String> listitem = ['SEE', '+2', 'Bachelor', 'Master', 'Phd'];
  TextEditingController organizationName = TextEditingController();
  TextEditingController achievement = TextEditingController();

  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Educational Details"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              validator: (text) {
                final regex = RegExp(r'^[a-zA-Z]+$');
                if (text == null || text.isEmpty) {
                  return "should not be empty";
                } else if (text.length > 10) {
                  return 'Length size=10';
                } else if (!regex.hasMatch(text)) {
                  return "accepts only character";
                }
                return null;
              },
              controller: organizationName,
              decoration: InputDecoration(
                labelText: 'Organization Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black87, width: 3),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Level"),
                DropdownButton(
                    hint: const Text("Select Items:"),
                    value: valueChoose,
                    onChanged: (newVal) {
                      setState(() {
                        valueChoose = newVal!;
                      });
                    },
                    items: listitem.map((String valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList()),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "should not be empty";
                }
                return null;
              },
              readOnly: true,
              controller: startdate,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "Select Starting Date"),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2024));
                if (pickeddate != null) {
                  setState(() {
                    startdate.text =
                        DateFormat('yyyy-MM-dd').format(pickeddate);
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "should not be empty";
                }
                return null;
              },
              readOnly: true,
              controller: enddate,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "Select Ending Date"),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2024));
                if (pickeddate != null) {
                  setState(() {
                    enddate.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (text) {
                final regex = RegExp(r'^[a-zA-Z]+$');
                if (text == null || text.isEmpty) {
                  return "should not be empty";
                } else if (text.length > 10) {
                  return 'Length size=10';
                } else if (!regex.hasMatch(text)) {
                  return "accepts only character";
                }
                return null;
              },
              controller: achievement,
              decoration: InputDecoration(
                labelText: ('Achievements'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black87, width: 3),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    eduFieldsList.add(Edudetails(
                      organizationName: organizationName.text,
                      level: valueChoose,
                      startdate: startdate.text,
                      enddate: enddate.text,
                      achievements: achievement.text,
                    ));
                  });
                  print('clicked');
                  Navigator.pop(context, eduFieldsList);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Submitted')),
                  );
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
