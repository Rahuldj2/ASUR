import 'dart:convert';

import 'package:Asur/Face_Auth/faceDetection.dart';
import 'package:flutter/material.dart';

import '../Global_Vairables/classCard.dart';
import 'package:http/http.dart' as http;
import '../Models/classModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ClassModel> classes = [
  ClassModel('CSD101', 'Harish Karnick',  true),
  ClassModel('CSD102', 'Harish Karnick',  false),
  ClassModel('CSD103', 'Harish Karnick',  false),
  ClassModel('CSD104', 'Harish Karnick',  false),
  ClassModel('CSD105', 'Harish Karnick',  false)
  ];


  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<ClassModel> fetchedClasses = data.map((item) {
        return ClassModel(
          item['Subject_ID'],
          item['Teacher_ID'],
          item['LIVE'] == 'L',
        );
      }).toList();

      setState(() {
        classes = fetchedClasses;
      });
    } else {
      throw Exception('Failed to load data');
    }
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
            child: Container(
              height: height*0.8,
              width: width*0.88,
              child: ListView.builder(

                  itemCount: classes.length,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
if(classes[index].live){
// open the face recognition
Navigator.push(context, MaterialPageRoute(builder: (_) => FaceApp()));
}
                        },

                        child: ClassCard(
                        atten_percent: 79.3,
                          classm: classes[index],

                        ),
                      ),
                    );
                  }),
            ),
          ),
        )


    );
  }
}
