import 'package:flutter/material.dart';

class AttendanceRecords extends StatefulWidget {
  const AttendanceRecords({super.key});

  @override
  State<AttendanceRecords> createState() => _AttendanceRecordsState();
}

class _AttendanceRecordsState extends State<AttendanceRecords> {
  @override
  Widget build(BuildContext context) {
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
              "Attendace Records",
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
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(Icons.construction,size: 55,),
              ),
              SizedBox(height: 10,),
              Text("Page Under Construction , Come back later")
            ],
          ),

        ),
      ),
    );
  }
}
