import 'package:flutter/material.dart';

class LocationChecks extends StatefulWidget {
  const LocationChecks({super.key});

  @override
  State<LocationChecks> createState() => _LocationChecksState();
}

class _LocationChecksState extends State<LocationChecks> {
  int inside=0;
  int checksdone=0;
bool live = false;
  String noclass = 'No class live now come back later';
  late String passedc ;

  void init(){
    passedc = "Inside of class ${inside.toString()} / ${checksdone.toString()}";
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
              "Your attendace progress",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.menu,
                size: 26,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        height: height*0.88,

        child: Center(
          child: Container(
            height: height*0.4,
            width: width*0.8,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(22)
            ),
            child: Center(
              child: Text(
live?passedc:noclass,style: TextStyle(color: Colors.white,fontSize: 19),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
