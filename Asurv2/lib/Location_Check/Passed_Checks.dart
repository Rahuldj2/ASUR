import 'package:Asur/Face_Auth/secondfaceauth.dart';
import 'package:Asur/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:timezone/timezone.dart' as tz;
import '../Face_Auth/faceDetection.dart';
import '../main.dart';
class LocationChecks extends StatefulWidget {
  const LocationChecks({super.key});

  @override
  State<LocationChecks> createState() => _LocationChecksState();
}

class _LocationChecksState extends State<LocationChecks> {
  int inside = 0;
  int checksdone = 0;
  bool live = false;
  String text ="";
  String text1 ="";
  String text2 ="";
  bool loading = false;
  String noclass = 'No class live now come back later';
  late String passedc;
  final info = NetworkInfo();
Future<String>getNetworkdetails() async {
  setState(() {
    loading= true;
  });

  final wifiName = await info.getWifiName(); // "FooNetwork"
  print('Wifi Name $wifiName');
    final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
  final wifiIP = await info.getWifiIP();
  final wifiIPv6 = await info.getWifiIPv6();
  print('wifi ip $wifiIP');
  text= wifiBSSID!;
  text1= wifiIP!;
  text2= wifiIPv6!;
  setState(() {
    loading= false;
  });
  return wifiIP.toString();
  }
// 192.168.1.43
  void init() {
    passedc = "Inside of class ${inside.toString()} / ${checksdone.toString()}";
    getNetworkdetails();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // getNetworkdetails();
  }

  void showNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "notifications-youtube",
        "YouTube Notifications",
        priority: Priority.max,
        importance: Importance.max
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channelId', 'channelName',
     importance: Importance.high,
     priority: Priority.max,
    );
     NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(0, "test", "face scan required", notificationDetails,payload: "faceApp");
 //   DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    // await notificationsPlugin.zonedSchedule(
    //     0,
    //     "Sample Notification",
    //     "This is a notification",
    //     tz.TZDateTime.from(scheduleDate, tz.local),
    //     notiDetails,
    //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    //     androidAllowWhileIdle: true,
    //     payload: "notification-payload"
    // );
  }





  void checkForNotification() async {
    NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();
    print('here');
    if(details != null) {
      if(details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if(response != null) {
          String? payload = response.payload;

          print("Notification Payload: $payload");
          navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => FaceApp("CSD203")));

        }
      }
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
      body:  loading
          ? Center(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1),
          child: const CircularProgressIndicator(color: Colors.black),
        ),
      )
          :RefreshIndicator(
            onRefresh: () async {
            await  getNetworkdetails();
            },
            child: Container(
        height: height * 0.88,
        child: Center(
            child: Container(
              height: height * 0.4,
              width: width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(22)),
              child: Column(
                children: [
                  Text(
            text,
                    style: TextStyle(color: Colors.white)

                  ),
                  SizedBox(height: 5,),
                  Text(
                      text1,
                      style: TextStyle(color: Colors.white)

                  ),
                  SizedBox(height: 5,),
                  Text(
                      text2,
                      style: TextStyle(color: Colors.white)

                  ),
                  SizedBox(height: 5,),
                  ElevatedButton(onPressed: (){
                  showNotification();
                  }, child: Text('Send Notification',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                          0xff912C2E), // Change this color to the desired background color
                    ),)
                ],
              ),
            ),
        ),
      ),
          ),
    );
  }
}
