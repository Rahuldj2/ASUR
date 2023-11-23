import 'package:Asur/Face_Auth/faceDetection.dart';
import 'package:Asur/Face_Auth/second_face_auth.dart';
import 'package:Asur/Navigator/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:Asur/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartChecks extends StatefulWidget {
  const StartChecks({Key? key}) : super(key: key);

  @override
  State<StartChecks> createState() => _StartChecksState();
}

class _StartChecksState extends State<StartChecks> {
  String text = "Start Service";
  String attt = "att not marked";
  int sk = 0;

  @override
  void initState() {
    super.initState();
    _initBackgroundService();
  }

  Future<void> _initBackgroundService() async {
    await Permission.location.request();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final prefs = await SharedPreferences.getInstance();
    sk = prefs.getInt('performedaction') ?? 0;
    print('updated sk $sk');
    setState(() {});
  }

  Future<int> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int a = prefs.getInt(key) ?? 0;
    return a;
  }

  Future<void> _stopService() async {
   // await  Future.delayed(Duration(seconds: 15));
    final service = FlutterBackgroundService();
    final isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke('stopService');
      saveDatab("FaceMatch", false);
      text = 'Class finished';
    }
  }

  Future<void> _startOrStopService() async {
    final service = FlutterBackgroundService();
    final isRunning = await service.isRunning();

    if (isRunning) {
      service.invoke('stopService');
      saveDatab("FaceMatch", false);
      setState(() {
        saveData('performedaction', 0);
        text = 'Start Service';
      });
    } else {
      print('starting');
      service.startService();
      setState(() {
        text = 'Stop Service';
      });
    }
  }

  Future<void> saveData(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> saveDatab(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }



  Future<void>showNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "notifications-youtube",
      "YouTube Notifications",
      priority: Priority.max,
      importance: Importance.max,
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Show the initial notification


    // Start the timer for 60 seconds
    int timerSeconds = 5;
    while (timerSeconds > 0) {
      // Update the notification every second with the remaining time
      await Future.delayed(Duration(seconds: 1));
      timerSeconds--;

      // Update the notification content with the remaining time
      if(timerSeconds >0){
        await notificationsPlugin.show(
          1,
          "test",
          "Time remaining: $timerSeconds seconds",
          notiDetails,
          payload: "faceApp",
        );
      }

    }

    // Cancel the notification after the timer ends
    await notificationsPlugin.cancel(1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff912C2E),
        title: Row(
          children: [

            SizedBox(
              width: 13,
            ),
            const Column(
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
                  "Start  your checks",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/startchecks.jpg"),

            SizedBox(height: 10),
            Text("Start Service , Sit Back and Study "),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(
                    0xff912C2E), // Change this color to the desired background color
              ),
              onPressed: () async {
                _startOrStopService();
              },
              child: Text(text),
            ),
            SizedBox(height: 10),
            StreamBuilder<Map<String, dynamic>?>(
              stream: FlutterBackgroundService().on('update'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!;
                int? times = data["actionper"] ?? 0;
                bool live = data["classliveornot"];
                bool atm = data?["atm"] ?? false;



                if (!live) {
                  // Schedule a setState call after the build has completed

                    _stopService().then((_) async {
                      // Code to execute after _stopService has completed.
                      String  justlive = await loadDataString('currlive');
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('currlive');
                  showNotification();
                      navigatorKey.currentState!.push(
                          MaterialPageRoute(builder: (context) => SecondFaceAuth(justlive)));


                    });

                }

                return Column(
                  children: [
                    Text('performed ${times.toString()} times'),
                    SizedBox(height: 8,),
                    Text(attt),
                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
