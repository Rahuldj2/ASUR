import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:Asur/Location_Check/StartChecks.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:Asur/SplashScreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Face_Auth/faceDetection.dart';
import 'Models/LiveClassmode.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.t);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff912C2E),
      statusBarColor: Color(0xff080303) // Make navigation bar translucent
      ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeService();
  AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/splash");

  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings
  );

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings,

      onDidReceiveNotificationResponse: (response) {
        print('here');
        print(response.payload.toString());
        onSelectNotification(response.payload);


      },




  );

  print("Notifications: $initialized");
  runApp(const MyApp());
}

Future<void> onSelectNotification(String? payload) async {
  String? screenToOpen = payload;
  if (screenToOpen != null) {
    if (screenToOpen == 'faceApp') {
      print('down');
      navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => FaceApp("CSD203")));
    } else if (screenToOpen == 'otherScreen') {
      // Handle other screens if needed
    }
  }
}



//-------------------------------------------------------FLUTTER BACKGROUND SERVICES CODE------------------------------//
String email = "";
String Rollno = "";
CollectionReference usersCollection =
FirebaseFirestore.instance.collection('Users');
Position? _smoothedLocation;
StreamSubscription<Position>? _locationSubscription;
bool _isSmoothingInProgress = false;
Position? _currentLocation;
double? alititude;
final double alpha = 0.15;
double? smoothedLatitude;
double? smoothedLongitude;
int stableCounter = 0;
int maxStableCounter = 3;
Timer? _countdownTimer;
int remainingTime = 40;
String tt = "Starting";
double centerX = 28.525909; // Example latitude of the center
double centerY = 77.576049; // Example longitude of the center
double semiMajorAxis = 14.5; // Semi-major axis in meters
double semiMinorAxis =11;


Future<void> _startLocationSmoothing() async {
  print('andar aaya');
  _isSmoothingInProgress = true; // Start smoothing process
    remainingTime = 60; // Reset the remaining time


  // Start the countdown timer
  _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {

      remainingTime = 50 - timer.tick; // Update the remaining time


    // Check if the timer has expired
    if (timer.tick >= 50) {
      print('timer expired');
      timer.cancel(); // Stop the timer
      _handleTimerExpiration();
    }
  });

  // Request location permissions

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );


    _locationSubscription?.cancel();
    // Permissions granted, start listening to location updates
    _locationSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {

        _currentLocation = position;

        if (_smoothedLocation == null) {
          // Initialize _smoothedLocation with the first raw location
          print('first location ');
      _smoothedLocation = _smoothLocation(position);
        } else {
          // Apply EMA to smooth the latitude and longitude

            tt = 'Stabilizing location -->';

          print('Stabilizing location -->');
          _smoothedLocation = _smoothLocation(position);
        }

        // Check if the smoothed location has become stable
        if (_isLocationStable(_smoothedLocation)) {
          stableCounter++;
        } else {
          stableCounter = 0;
        }

        // If the location has been stable for a certain number of consecutive updates, stop updating
        if (stableCounter >= maxStableCounter) {

            tt = "Stabilized->";
            _isSmoothingInProgress = false;

          print('Stabilized->');
          remainingTime = 0;
          _locationSubscription?.cancel();
        }

    });

}
bool _isLocationStable(Position? location) {
  if (_smoothedLocation == null) {
    return false;
  }
  final double latitudeDiff =
      (_smoothedLocation!.latitude - location!.latitude).abs();
  final double longitudeDiff =
      (_smoothedLocation!.longitude - location.longitude).abs();
  return latitudeDiff < 0.0001 && longitudeDiff < 0.0001;
}

void _handleTimerExpiration() {
  _isSmoothingInProgress = false;
  _locationSubscription?.cancel();
}

Position _smoothLocation(Position rawLocation) {
  if (_smoothedLocation == null) {
    smoothedLatitude = rawLocation.latitude;
    smoothedLongitude = rawLocation.longitude;
  } else {
    smoothedLatitude =
        alpha * rawLocation.latitude + (1 - alpha) * smoothedLatitude!;
    smoothedLongitude =
        alpha * rawLocation.longitude + (1 - alpha) * smoothedLongitude!;
  }
  return Position(
    latitude: smoothedLatitude!,
    longitude: smoothedLongitude!,
    timestamp: rawLocation.timestamp,
    accuracy: rawLocation.accuracy,
    altitude: rawLocation.altitude,
    heading: rawLocation.heading,
    speed: rawLocation.speed,
    speedAccuracy: rawLocation.speedAccuracy,
    altitudeAccuracy: rawLocation.altitudeAccuracy,
    headingAccuracy: rawLocation.headingAccuracy,
  );
}

// Check if a point is inside the ellipse defined by center, semiMajorAxis, and semiMinorAxis
bool isPointInsideEllipse(double centerX, double centerY, double semiMajorAxis,
    double semiMinorAxis, double lat, double lon) {
  double distance = haversine(centerX, centerY, lat, lon);

  return (distance / semiMajorAxis) * (distance / semiMajorAxis) +
          (distance / semiMinorAxis) * (distance / semiMinorAxis) <=
      1;
}

double haversine(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // Earth's radius in meters

  lat1 = degreesToRadians(lat1);
  lon1 = degreesToRadians(lon1);
  lat2 = degreesToRadians(lat2);
  lon2 = degreesToRadians(lon2);

  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180.0);
}

Future<void> saveData(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<int> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  int? a = prefs.getInt(key) ?? 0;

  return a;
}

Future<String> loadDataString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String a = prefs.getString(key) ?? "NL";
  return a;
}

Future<bool> classLiveorNot(String courseCode) async {
  print('course code $courseCode');
 String baseUrl =
      'https://asur-ams.vercel.app/api/CheckLive?coursecode="$courseCode"'; // Replace with your server's API endpoint



  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    // Successful request
    final Map<String,dynamic> data = json.decode(response.body);
    // Parse and use the data as needed
    print("Data from the server: $data");
    if (data["LIVE"] == "NL") {
      return false;
    } else {
      print('class is still live');
      return true;
    }
  } else {
    // Request failed
    print("Failed to fetch data. Status code: ${response.statusCode}");
  }
  return false;
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

          Rollno = rollNoValue.toString();
          print('roll number $Rollno');

      }

      //   print(attenper.toString());
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print('Error fetching data2: $error');
  }
}
















// GET SAVED CLASS ROOM DETAILS
Future<void> getClassRoomDetailsFromLocalStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the JSON-encoded string from local storage
  final jsonEncoded = prefs.getString('lcd'); // Replace with your key

  if (jsonEncoded != null) {
    // Deserialize the JSON-encoded string back to a LiveClass object
    final liveClass = LiveClass.fromJson(json.decode(jsonEncoded));
    centerX = liveClass.cenlatitude;
    centerY = liveClass.cenlongitude;
    semiMajorAxis = liveClass.majorAxis;
    semiMinorAxis = liveClass.minorAxis;
    alititude = liveClass.altitude;
  }
}
// MARK SOME PRESENT
Future<void> markAttendance(String coursecode,String attendanceStatus) async {

  final url = 'https://asur-ams.vercel.app/api/MarkAttendance'; // Replace with your API endpoint URL

  final stud_id = Rollno; // Replace with the student ID
  final  course_id = coursecode; // Replace with the course ID

  final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final attendance_status = attendanceStatus; // Replace with the attendance status

  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'stud_id': stud_id.toString(),
        'course_id': "$course_id",
        'date': "${date.toString()}",
        'attendance_status': "$attendance_status",
      },
    );

    if (response.statusCode == 200) {
      // Attendance marked successfully
      print('Attendance marked successfully');
    } else {
      // Error marking attendance
      print('Error marking attendance ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions
    print('Exception: $e');
  }
}







Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
        onStart: onStart, isForegroundMode: true, autoStart: false),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 70), (timer) async {


    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {


        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }

    print('Started....');
    //await   getClassRoomDetailsFromLocalStorage();  // commented this because data is not there in database
    String courseCode = await loadDataString("currlive");
    bool cl = await classLiveorNot(courseCode);

    // if class is live and smoothing is not in progress then do the task
    if (cl ) {
      stableCounter = 0;
      _smoothedLocation = null;
      try {
        print('here');
     await  _startLocationSmoothing();
      }catch(e){
        print('error in location smmothng $e');
      }
      print('delay started');
      await Future.delayed(Duration(seconds: 55));//60
      print('delay ended');
      _locationSubscription?.cancel();
      _countdownTimer?.cancel(); // Cancel the countdown timer manually
      _handleTimerExpiration(); // Trigger the check after the timer expires

      bool ch = smoothedLatitude != null && smoothedLongitude != null
          ? isPointInsideEllipse(centerX, centerY, semiMajorAxis, semiMinorAxis,
          smoothedLatitude!, smoothedLongitude!)
          : false; // or handle the case where one or both values are null

      print('checked if inside $ch');
      int s = await loadData('performedaction');
      s++;

      saveData('performedaction', s);
      print('s = ${s.toString()}');
      loadData('LocationChecks').then((value) {
        int? inside = value;
        print('inside value $inside');
        if (ch) {
          inside++;

          saveData('LocationChecks', inside);
        }
      });

      service.invoke(
        'update',
        {
          "actionper": s,
          "classliveornot": cl
          // this returns weather class is live or not (fetch this in startcheks file0
        },
      );

    } else {

     int fininside = await loadData('LocationChecks');
     print('final inside $fininside');
      Rollno=  await loadDataString("RollNo");
     if(fininside>=2){
       String courseCode = await loadDataString("currlive");
       print('Marking the user present');
        markAttendance(courseCode, 'P');
       print('attendance marked');
       saveData('LocationChecks', 0);
     }else{
       String courseCode = await loadDataString("currlive");
       print('Marking the user absent');
     await   markAttendance(courseCode, 'A');
       print('attendance marked');
        saveData('LocationChecks', 0);

     }
     saveData('performedaction', 0);
     service.invoke(
       'update',
       {

         "classliveornot": cl

       },
     );

      // first check total number of times one was inside the class and mark one present


// send the notification for again face scan
      // total checks need to be stored in  database currently for eval2 we are doing 3 scans
      print('Either class is not live or Previous smoothing has not Completed');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> requestPermissions() async {
    bool reqSuc = false;
    List<Permission> permissions = [
      Permission.location,
    ];

    for (Permission permission in permissions) {
      if (await permission.isGranted) {
        if (kDebugMode) {
          print("Permission: $permission already granted");
        }
        reqSuc = true;
        continue;
      } else if (await permission.isDenied) {
        PermissionStatus permissionsStatus = await permission.request();
        if (permissionsStatus.isGranted) {
          if (kDebugMode) {
            print("Permission: $permission already granted");
          }
          reqSuc = true;
        } else if (permissionsStatus.isPermanentlyDenied) {
          if (kDebugMode) {
            print("Permission: $permission is permanently denied");
          }
          reqSuc = false;
        }
      }
    }
    if (reqSuc == false) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestPermissions(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primaryColor: Color(0xff912C2E),
            hintColor: Color(0xff912C2E),
          ),
          title: 'ASURv2',
          home: SplashScreen(),

          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
