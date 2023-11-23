import 'package:Asur/Models/classModel.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ClassCard extends StatefulWidget {
  final ClassModel classm;
  final num atten_percent;

  ClassCard({required this.classm, required this.atten_percent});

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(17)),
      height: height * 0.12,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.grey,
            child: Icon(Icons.edit_calendar_outlined, color: Colors.white),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.classm.courseCode,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.classm.instructor_Name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          trailing: Container(
            width: width * 0.22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Center vertically
              children: [
                CircularPercentIndicator(
                  radius: height * 0.024, // Adjusted for responsiveness
                  lineWidth: 4.0,
                  percent: widget.atten_percent / 100,
                  center: Text(
                    widget.atten_percent.toString(),
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  progressColor: Colors.green,
                ),
                SizedBox(width: 12),
                widget.classm.live
                    ? Text(
                        "Live",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
