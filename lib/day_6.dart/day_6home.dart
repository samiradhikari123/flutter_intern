import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intern1/cv_display.dart';
import 'package:intern1/day_6.dart/otherprojects.dart';
import 'package:intern1/edudetails.dart';
import 'package:intern1/otprojfield.dart';
import '../checkboxlist.dart';
import '../viewdetails.dart';
import '../workexp_field.dart';
import 'work_exp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'education.dart';

class Day6 extends StatefulWidget {
  const Day6({super.key});

  @override
  State<Day6> createState() => _Day6State();
}

class _Day6State extends State<Day6> {
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  List<String> skills = [];

  List<String> selectedItems = [];
  List<String> checkedLanguageNames = [];
  final List<String> clipList = [
    'HTML',
    'Java Script',
    'Python',
    'ReactJS',
    'PHP',
    'Flutter',
  ];

  bool _switchvalue = false;

  void _onSkillsSelected(String skill) {
    setState(() {
      if (skills.contains(skill)) {
        skills.remove(skill);
      } else {
        skills.add(skill);
      }
    });
  }

  Future<void> savecv() async {
    Map<String, dynamic> cvemptyList = {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    // print("adas ${jsonString}");
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          cvFieldsLists =
              jsonData.map((json) => Cvdisplay.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          cvemptyList
              .addAll(Cvdisplay.fromJson(jsonData) as Map<String, dynamic>);
        }
        // print('Empty cv ${cvemptyList}');
      } catch (e) {
        rethrow;
        // print("error occured $e");
      }
    }

    cvFieldsLists.add(Cvdisplay(
      firstname: firstName.text,
      middleName: middleName.text,
      lastname: lastName.text,
      age: age.text,
      gender: _gender,
      skills: skills,
      workExperience: workFieldsList,
      educationDetails: eduFieldsList,
      otherProjects: projFieldsList,
      language: selectedItems,
      interestArea: checkedLanguageNames,
    ));
    List<Map<String, dynamic>> jsonDataList =
        cvFieldsLists.map((cv) => cv.tojson()).toList();
    cvemptyList[firstName.text] = jsonDataList;
    String jsonDate = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cirruculam Vitae",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(children: [
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
                        controller: firstName,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 3),
                          ),
                        ),
                      ),

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
                        controller: middleName,
                        decoration: InputDecoration(
                          labelText: 'Middle Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 3),
                          ),
                        ),
                      ),
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
                        controller: lastName,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          final regex = RegExp(r"^[0-9]+$");
                          if (value == null || value.isEmpty) {
                            return "should not be empty";
                          } else if (!regex.hasMatch(value)) {
                            return "accepts only digits";
                          }
                          return null;
                        },
                        controller: age,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 3),
                          ),
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Gender',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Radio(
                                  value: 'Male',
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value ?? '';
                                    });
                                  },
                                ),
                                const Text('Male'),
                                Radio(
                                  value: 'Female',
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value ?? '';
                                    });
                                  },
                                ),
                                const Text('Female'),
                                Radio(
                                  value: 'Others',
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value ?? '';
                                    });
                                  },
                                ),
                                const Text('Others'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Text("Skills"),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: clipList.map((skill) {
                          return FilterChip(
                            label: Text(skill),
                            selected: skills.contains(skill),
                            onSelected: (selected) => _onSkillsSelected(skill),
                            selectedColor: Colors.indigo,
                            backgroundColor: Colors.lime,
                            checkmarkColor: Colors.pink,
                          );
                        }).toList(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Work Experience'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Workexperience()));
                            },
                            child: const Text('Select experience'),
                          )
                        ],
                      ),
                      Wrap(
                        //used for wraping display box below the TextFrmField and elevated button for work experience
                        runSpacing: 9.0,
                        children: _workFieldsUi(),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Educational Details'),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Education()));
                              },
                              child: const Text('Education'),
                            ),
                          ]),
                      Wrap(
                        //used for wraping display box below the TextFrmField and elevated button for Education Details
                        runSpacing: 9.0,
                        children: _eduFieldsUi(),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Other Projects'),
                            Switch(
                              value: _switchvalue,
                              onChanged: (value) {
                                setState(() {
                                  _switchvalue = value;
                                  if (value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Otherprojects()));
                                  }
                                });
                              },
                            ),
                          ]),
                      Wrap(
                        //used for wraping display box below the TextFrmField and elevated button for Education Details
                        runSpacing: 9.0,
                        children: _proFieldsUi(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Languages'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: languageList.map((e) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: e['isChecked'],
                                  onChanged: (newVal) {
                                    setState(() {
                                      e['isChecked'] = newVal;
                                      if (e['isChecked'] == true) {
                                        checkedLanguageNames.add(e["name"]);
                                      } else {
                                        checkedLanguageNames.remove(e["name"]);
                                      }
                                    });
                                  },
                                ),
                                Text(e["name"]),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const Text('Interest Areas'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: intrestList.map((e) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: e['isCheck'],
                                  onChanged: (newVal) {
                                    setState(() {
                                      e['isCheck'] = newVal;
                                      if (e['isCheck'] == true) {
                                        selectedItems.add(e["name"]);
                                      } else {
                                        selectedItems.remove(e["name"]);
                                      }
                                    });
                                  },
                                ),
                                Text(e["name"]),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              savecv();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data Submitted'),
                                ),
                              );
                            });
                          }
                        },
                        child: const Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewDetails()));
                        },
                        child: const Text('View Details'),
                      ),
                    ]),
                  ))),
        ));
  }

  List<Widget> _workFieldsUi() {
    //work Experience field
    // used to call the workexperience details in the display box in the main page
    return workFieldsList.map(
      (e) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Job Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.jobTitle)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Summary: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.summary)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Company Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.companyName)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startdate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.enddate)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        workFieldsList.remove(e);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _eduFieldsUi() {
    // edu list
    return eduFieldsList.map(
      (e) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Organization Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Level: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.level)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Starting Date:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startdate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.enddate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Achievements: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.achievements)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        eduFieldsList.remove(e);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _proFieldsUi() {
    // other Projects field
    return projFieldsList.map(
      (e) {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Project Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.projectTitle)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Description:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.description)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startdate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.enddate)
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Organization name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        projFieldsList.remove(e);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }
}
