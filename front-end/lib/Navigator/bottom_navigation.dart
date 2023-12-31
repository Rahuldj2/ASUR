import 'package:Asur/Location_Check/Passed_Checks.dart';
import 'package:Asur/Location_Check/StartChecks.dart';
import 'package:Asur/Profile/profile.dart';
import 'package:Asur/attendaceTable/AttendanceRecords.dart';
import 'package:Asur/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/homepage.dart';

class BottomNavigation extends StatefulWidget {
  final int? passedindex;
  const BottomNavigation(this.passedindex);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool facematch = false;
  int _selectedIndex = 0;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    // Set the initial selected index based on the passedindex or use 0 if not provided
    setState(() {
      loading = true;
    });
    loadData("FaceMatch");
    loadscreens();
    _selectedIndex = widget.passedindex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      loading = true;
      _selectedIndex = index;
      loadData("FaceMatch");
      loadscreens();
    });
  }

  Future<void> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    facematch = prefs.getBool(key) ?? false;
  }

  List? screens = [];

  void loadscreens() {
    if (facematch) {
      screens = [
        const HomePage(),
        //const LocationChecks(),
        const StartChecks(),
        const AttendanceRecords(),
        const Profile(),
      ];
    } else {
      screens = [
        const HomePage(),
        const LocationChecks(),
        //    const StartChecks(),
        const AttendanceRecords(),

        const Profile(),
      ];
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: const CircularProgressIndicator(color: Colors.white),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: screens?[_selectedIndex],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 9, right: 9, top: 9),
        child: Container(
            height: MediaQuery.sizeOf(context).height * 0.08,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              //borderRadius: BorderRadius.circular(12),
              //  border: Border.all(color: AppColors.primaryColor, width: 2.9)
            ),
            child: BottomNavigationBar(
              elevation: 4,
              iconSize: 28,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              selectedItemColor: Color(0xff912C2E),
              unselectedItemColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.trending_up,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.credit_card,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: ''),
              ],
            )),
      ),
    );
  }
}
