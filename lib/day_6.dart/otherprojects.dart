import 'package:flutter/material.dart';
import 'package:intern1/otprojfield.dart';

import 'package:intl/intl.dart';

class Otherprojects extends StatefulWidget {
  const Otherprojects({super.key});

  @override
  State<Otherprojects> createState() => _OtherprojectsState();
}

class _OtherprojectsState extends State<Otherprojects> {
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  TextEditingController projectTitle = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController organizationName = TextEditingController();
  String groupValue = "no";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Projects"),
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
              controller: projectTitle,
              decoration: InputDecoration(
                labelText: 'Project Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black87, width: 3),
                ),
              ),
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
              controller: description,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black87, width: 3),
                ),
              ),
            ),
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
            Row(
              children: [
                const Text('Associated With Any Organization'),
                Radio(
                    value: 'no',
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
                const Text('No'),
                Radio(
                    value: 'yes',
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
                const Text('Yes'),
              ],
            ),
            if (groupValue == 'yes')
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
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 3),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {});
                  {
                    projFieldsList.add(OtherProjField(
                      projectTitle: projectTitle.text,
                      description: description.text,
                      enddate: enddate.text,
                      startdate: startdate.text,
                      organizationName: organizationName.text,
                    ));
                  }
                  print('clicked');
                  Navigator.pop(context, projFieldsList);
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
