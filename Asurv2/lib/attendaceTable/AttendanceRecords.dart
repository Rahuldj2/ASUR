import 'dart:convert';
import 'package:Asur/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class AttendanceRecords extends StatefulWidget {
  const AttendanceRecords({super.key});

  @override
  State<AttendanceRecords> createState() => _AttendanceRecordsState();
}

class _AttendanceRecordsState extends State<AttendanceRecords> {
  String selectedCourse = '';
  String RollNo="";
  String text ="";
  bool loading = false;
  List<String> classes = [];
  DateTime selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    final response =
    await http.get(Uri.parse('https://asur-ams.vercel.app/api/GetCourseList'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      for (var subject in data) {
        classes.add(subject['Subject_ID']);
        print("${subject['Subject_ID']}");
      }
 RollNo = await loadDataString("RollNo");
      setState(() {
        loading = false;
      });
    }
  }




  Future<void> fetchDataFromServer(String date) async {
    setState(() {
      loading= true;
    });
    final Uri uri = Uri.parse('https://asur-ams.vercel.app/api/GetAttByDate?date="$date"&rollNum=$RollNo&courseCode="$selectedCourse"'); // Replace with your server's endpoint.

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        // Include query parameters in the URL
        // Example: /endpoint?date=2023-11-06&rollNum=123&courseCode=ABC
        // Adjust the query parameters as needed
        // Replace values with your data
        // date, rollNum, and courseCode should be the actual values you want to use
        // They should be URL-encoded if necessary
        // (use Uri.encodeComponent() for each value if needed)
        // For example: ?date=${Uri.encodeComponent(date)}&rollNum=${Uri.encodeComponent(rollNum)}&courseCode=${Uri.encodeComponent(courseCode)}
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Handle the response data here
        print(responseData);

        setState(() {
          text = responseData['PorA'];
          loading= false;
        });
      } else {
        // Handle the case where the server returned an error
        print('Error: ${response.statusCode}');
        setState(() {
          loading= false;
        });
      }
    } catch (e) {
      // Handle any other errors that may occur during the HTTP request
      print('Error: $e');
    }
  }






  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff912C2E),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ASUR",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Attendance Records",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: loading
            ? Center(
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1),
            child: CircularProgressIndicator(
              color: Color(0xff912C2E),
            ),
          ),
        )
           :
  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 35,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color:  Color(0xff912C2E)),
                  borderRadius: BorderRadius.circular(22)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 13.0),
                child: DropDown<String>(
                  items: classes,
                  initialValue: selectedCourse!=""?selectedCourse:"CSD101",
                  hint: Text("Select Course Code"),
                  onChanged: (value) {
                    selectedCourse = value!;
                  },
                  showUnderline: false,
                  dropDownType: DropDownType.Button,


                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color:  Color(0xff912C2E)),
                  borderRadius: BorderRadius.circular(22)
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2023,01,01),
                  lastDay: DateTime.now(),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(selectedDate, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                       selectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement your action when the "Check" button is pressed
             await   fetchDataFromServer(DateFormat('yyyy-MM-dd').format(selectedDate).toString());
                print('Course: $selectedCourse');
                print('Date: $selectedDate');
              },
              child: Text(
                'Check',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xff912C2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              text == 'P'
                  ? "Present on ${DateFormat('dd-MM-yyyy').format(selectedDate)}"
                  : text == 'A'
                  ? "Absent on ${DateFormat('dd-MM-yyyy').format(selectedDate)}"
                  : "",
              style: text == 'P'
                  ? TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 18)
                  : text == 'A'
                  ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18)
                  : TextStyle(color: Colors.black), // Adjust as needed
            )


          ],
        ),
      ),
    );
  }
}


