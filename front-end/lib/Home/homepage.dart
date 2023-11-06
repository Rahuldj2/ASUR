import 'dart:convert';

import 'package:Asur/Face_Auth/faceDetection.dart';
import 'package:Asur/Location_Check/StartChecks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global_Vairables/classCard.dart';
import 'package:http/http.dart' as http;
import '../Models/AttendanceModel.dart';
import '../Models/classModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ClassModel> classes = [];
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  bool loading = false;
  bool facematch = false;
  String email = "";
  String Rollno = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    fetchData();
    fetchUserEmail();

    loadData("FaceMatch");
    // Call the function to fetch data from the API when the widget is created.
  }

  // FETCHING ENROLLED COURSES DATA
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://asur-ams.vercel.app/api/GetCourseList'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<ClassModel> fetchedClasses = data.map((item) {
        return ClassModel(
          item['Subject_ID'],
          item['TeacherName'],
          item['LIVE'] == 'L'
        );
      }).toList();

      setState(() {
        classes = fetchedClasses;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  List<AttendanceModel> attenper = [];
  // attendance percentage for particular student for sunjects
  Future<void> fetchAttendance(String rollNo) async {
    final String url = 'https://asur-ams.vercel.app/api/GetAttendancePercent';

    try {
      final response = await http.get(Uri.parse('$url?rollNo=$Rollno'));

      if (response.statusCode == 200) {
        //   final data = json.decode(response.body);
        // Process the data as needed
        final List<dynamic> data = json.decode(response.body);
        final List<AttendanceModel> fetchedClasses = data.map((item) {
          return AttendanceModel(
            subjectID: item['Subject_ID'],
            percentage: item['Percentage'],
          );
        }).toList();
        setState(() {
          attenper = fetchedClasses;
          //loading = false;
        });
        print(attenper.toString());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data1: $error');
    }
  }

  // get roll number from email
  Future<void> fetchRollNo(String email) async {
    final String url = 'https://asur-ams.vercel.app/api/GetRollNumFromEmail';

    try {
      print('trimmed email $email');
      final response = await http.get(Uri.parse('$url?email="$email"'));

      if (response.statusCode == 200) {
        //   final data = json.decode(response.body);
        // Process the data as needed
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final int rollNoValue =
              data[0]['roll_no']; // Access the first item in the list
          setState(() {

            Rollno = rollNoValue.toString();
            print('roll number $Rollno');

          });
         await saveData("RollNo", Rollno);
        }

        //   print(attenper.toString());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data2: $error');
    }
  }

// MATCHING COURSE CODE WITH CORRESPONDING ATTENDANCE
  num matchdata(String coursecode) {
    for (int i = 0; i < attenper.length; i++) {
      if (attenper[i].subjectID == coursecode) {
        return attenper[i].percentage;
      }
    }
    return 70;
  }

// FETCH DATA FROM FIREBASE

  Future<void> fetchUserEmail() async {
    setState(() {
      loading = true;
    });

    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      User? user = FirebaseAuth.instance.currentUser;
      if (uid != null) {
        DocumentSnapshot userDocument = await usersCollection.doc(uid).get();

        if (userDocument.exists) {
          Map<String, dynamic> data =
              userDocument.data() as Map<String, dynamic>;

          // Process data as needed

          email = data['email'];

          print(' Email: $email');

          await fetchRollNo(email);
          await fetchAttendance(Rollno);
        } else {
          print('User document does not exist');
        }
      } else {
        print('User is not signed in');
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      print('Error fetching data3: $e');
    }
  }

  Future<void> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    facematch = prefs.getBool(key) ?? false;
    print('face $facematch');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff912C2E),
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ASUR",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "see your attendance",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: loading
                ? Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: const CircularProgressIndicator(
                          color: Color(0xff912C2E)),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        loading = true;
                      });
                      await fetchData();
                      await fetchUserEmail();

                      await loadData("FaceMatch");
                    },
                    child: Container(
                      height: height * 0.8,
                      width: width * 0.88,
                      child: ListView.builder(
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  if (classes[index].live &&
                                      facematch == false) {
// open the face recognition
//saveData("liveClass", classes[index].courseCode);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FaceApp(
                                                classes[index].courseCode)));
                                  }
// if face matching has already been done
                                  if (classes[index].live && facematch) {
// open the face recognition

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => StartChecks()));
                                  }
                                },
                                child: ClassCard(
                                  atten_percent:
                                      matchdata(classes[index].courseCode),
                                  classm: classes[index],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
          ),
        ));
  }

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
