import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cv_display.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({super.key});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  List<Cvdisplay> cvdetails = [];

  Future<List<String>> getCvData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    // print("dffd ${jsonData}");

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          cvdetails = decodedData.map((e) => Cvdisplay.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;

        // print("error occured fgfgjf $e");
      }
    } else {
      cvdetails = [];
    }
    return [];
  }

  delete() async {
    var todelete = await SharedPreferences.getInstance();
    todelete.clear();
  }

  @override
  void initState() {
    super.initState();
    getCvData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
              onPressed: () {
                delete();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: cvdetails.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "User ${index + 1}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w200),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('First Name:${cvdetails[index].firstname}'),
                  const SizedBox(height: 10),
                  Text('Middle Name:${cvdetails[index].middleName}'),
                  const SizedBox(height: 10),
                  Text('Last Name:${cvdetails[index].lastname}'),
                  const SizedBox(height: 10),
                  Text('Age:${cvdetails[index].age}'),
                  const SizedBox(height: 10),
                  Text('Skills:${cvdetails[index].skills.join(',')}'),
                  const Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 18,
                      // color: Colors.cyanAccent,
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cvdetails[index].educationDetails.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                            color: const Color.fromARGB(255, 214, 159, 142),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Organization Name: ${cvdetails[index].educationDetails[i].organizationName}'),
                                  Text(
                                      'Education: ${cvdetails[index].educationDetails[i].level}'),
                                  Text(
                                      'Entry Date: ${cvdetails[index].educationDetails[i].startdate}'),
                                  Text(
                                      'Exit DAte: ${cvdetails[index].educationDetails[i].enddate}'),
                                  if (cvdetails[index]
                                      .educationDetails[i]
                                      .achievements
                                      .isNotEmpty)
                                    Text(
                                        "Achievements: ${cvdetails[index].educationDetails[i].achievements}")
                                ],
                              ),
                            ));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Work Experience'),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cvdetails[index].workExperience.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                            color: const Color.fromARGB(255, 202, 152, 137),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Job Title: ${cvdetails[index].workExperience[i].jobTitle}'),
                                  Text(
                                      'SUmmary: ${cvdetails[index].workExperience[i].summary}'),
                                  Text(
                                      "Company Name: ${cvdetails[index].workExperience[i].companyName}"),
                                  Text(
                                      'Entry Date: ${cvdetails[index].workExperience[i].startdate}'),
                                  Text(
                                      'Exit DAte: ${cvdetails[index].workExperience[i].enddate}'),
                                ],
                              ),
                            ));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Other Projects'),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cvdetails[index].otherProjects.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                            color: const Color.fromARGB(255, 194, 155, 143),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Project Title: ${cvdetails[index].otherProjects[i].projectTitle}'),
                                  Text(
                                      'Description: ${cvdetails[index].otherProjects[i].description}'),
                                  Text(
                                      'Entry Date: ${cvdetails[index].otherProjects[i].startdate}'),
                                  Text(
                                      'Exit DAte: ${cvdetails[index].otherProjects[i].enddate}'),
                                  if (cvdetails[index]
                                      .otherProjects[i]
                                      .organizationName
                                      .isNotEmpty)
                                    Text(
                                        'Organiztion name${cvdetails[index].otherProjects[i].organizationName}'),
                                ],
                              ),
                            ));
                      }),
                  const SizedBox(height: 10),
                  Text('Language:${cvdetails[index].language.join(',')}'),
                  const SizedBox(height: 10),
                  Text(
                      'Interest Area:${cvdetails[index].interestArea.join(',')}'),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 30,
                    color: Colors.deepPurpleAccent,
                    thickness: 5,
                    endIndent: 20,
                  )
                ],
              );
            }),
      ),
    );
  }
}
