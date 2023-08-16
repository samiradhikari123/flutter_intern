import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:socioapp/model/workexpfield.dart';

class Workexperience extends StatefulWidget {
  const Workexperience({super.key});

  @override
  State<Workexperience> createState() => _WorkexperienceState();
}

class _WorkexperienceState extends State<Workexperience> {
  TextEditingController jobTitle = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add work experience"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
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
                controller: jobTitle,
                decoration: InputDecoration(
                  labelText: 'Job Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 3),
                  ),
                ),
              ),
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
                controller: summary,
                decoration: InputDecoration(
                  labelText: 'Summary',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 3),
                  ),
                ),
              ),
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
                controller: companyName,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 3),
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
                      enddate.text =
                          DateFormat('yyyy-MM-dd').format(pickeddate);
                    });
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      workFieldsList.add(WorkExpField(
                          jobTitle: jobTitle.text,
                          summary: summary.text,
                          companyName: companyName.text,
                          startdate: startdate.text.toString(),
                          enddate: enddate.text.toString()));
                    });
                    print('clicked');
                    Navigator.pop(context, workFieldsList);
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
      ),
    );
  }
}
