import 'package:Asur/Navigator/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:Asur/main.dart';
import 'package:flutter/material.dart';
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
    int a  = prefs.getInt(key) ?? 0;
    return a;
  }

  Future<void> _stopService() async{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Color(0xff912C2E),
    title: Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 26,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomNavigation(0)));
            }),
        SizedBox(width: 13,),
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
            // ElevatedButton(
            //   onPressed: () async {
            //   _initBackgroundService();
            //     setState(() {});
            //   },
            //   child: Text('Check Times'),
            // ),
            // SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () async {
            //     FlutterBackgroundService().invoke("setAsForeground");
            //   },
            //   child: Text('Set as Foreground'),
            // ),
            // SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () async {
            //     FlutterBackgroundService().invoke("setAsBackground");
            //   },
            //   child: Text('Set as Background'),
            // ),
            SizedBox(height: 10),
            Text("Start Service , Sit Back and Study "),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff912C2E), // Change this color to the desired background color
              ),
              onPressed: () async {
                _startOrStopService();
              },
              child: Text(text),
            ),
            SizedBox(height: 10),
            StreamBuilder<Map<String, dynamic>?>(
              stream: FlutterBackgroundService().on('update'),
              builder: (context, snapshot)  {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!;

                int? times = data["actionper"];
                bool live =  data["classliveornot"];
                if(live){
                  _stopService().then((_) {
                    // Code to execute after _stopService has completed.
                  });
                }
                return Column(
                  children: [

                    Text('performed ${times.toString()} times'),
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
