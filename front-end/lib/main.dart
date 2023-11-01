import 'dart:async';
import 'dart:math';
import 'dart:ui';

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

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.t);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    systemNavigationBarColor: Color(0xff912C2E),
    statusBarColor:   Color(0xff080303)// Make navigation bar translucent
  ));
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform,);
  await initializeService();
  runApp(const MyApp());

}







//-------------------------------------------------------FLUTTER BACKGROUND SERVICES CODE------------------------------//




Position? _smoothedLocation;
StreamSubscription<Position>? _locationSubscription;
bool _isSmoothingInProgress = false;
Position? _currentLocation;
final double alpha = 0.2;
double? smoothedLatitude;
double? smoothedLongitude;
int stableCounter = 0;
int maxStableCounter = 3;
Timer? _countdownTimer;
int remainingTime = 60;
String tt = "Starting";
double centerX = 28.523442; // Example latitude of the center
double centerY = 77.570257; // Example longitude of the center
double semiMajorAxis = 2.3; // Semi-major axis in meters
double semiMinorAxis = 1.8; // these coordianates are for my room



Future<void> _startLocationSmoothing() async {
  _isSmoothingInProgress = true;
  remainingTime = 60;

  _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    remainingTime = 60 - timer.tick;
    if (timer.tick >= 60) {
      timer.cancel();
      _handleTimerExpiration();
    }
  });

  // Request location permissions
  // var permissionStatus = await Permission.location.status;


  var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled) {
    _locationSubscription?.cancel();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      _currentLocation = position;
      if (_smoothedLocation == null) {
        _smoothedLocation = _smoothLocation(position);
      } else {
        tt = 'Stabilizing location -->';
        print('Stabilizing location -->');
        _smoothedLocation = _smoothLocation(position);
      }
      if (_isLocationStable(_smoothedLocation)) {
        stableCounter++;
      } else {
        stableCounter = 0;
      }
      if (stableCounter >= maxStableCounter) {
        tt = "Stabilized->";
        _isSmoothingInProgress = false;
        print('Stabilized->');
        remainingTime = 0;
        _locationSubscription?.cancel();
      }
    });
  } else {
    print("Location service is not enabled.");
  }

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
    smoothedLatitude = alpha * rawLocation.latitude + (1 - alpha) * smoothedLatitude!;
    smoothedLongitude = alpha * rawLocation.longitude + (1 - alpha) * smoothedLongitude!;
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
bool isPointInsideEllipse(
    double centerX, double centerY, double semiMajorAxis, double semiMinorAxis,
    double lat, double lon) {
  double distance = haversine(centerX, centerY, lat, lon);

  return (distance / semiMajorAxis) * (distance / semiMajorAxis) +
      (distance / semiMinorAxis) * (distance / semiMinorAxis) <= 1;
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
    int a  = prefs.getInt(key) ?? 0;
    return a;
}

Future<String> loadDataString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String a  = prefs.getString(key) ?? "NL";
  return a;
}

Future<bool> classLiveorNot(String courseCode) async {
  final String baseUrl = "https://asur-ams.vercel.app/api"; // Replace with your server's API endpoint
  final String query = "courseCode=$courseCode"; // Replace with the query parameter you need

  final response = await http.get(Uri.parse('$baseUrl/LNL?$query'));

  if (response.statusCode == 200) {
    // Successful request
    final String data = response.body;
    // Parse and use the data as needed
    print("Data from the server: $data");
    if (data=="NL"){
      return false;
    }else{
      return true;
    }
  } else {
    // Request failed
    print("Failed to fetch data. Status code: ${response.statusCode}");
  }
  return false;
}








Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false
    ),
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

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    // if (service is AndroidServiceInstance) {
    //   if (await service.isForegroundService()) {
    //     service.setForegroundNotificationInfo(
    //       title: "Asur",
    //       content: "Updated at ${DateTime.now()}",
    //     );
    //   }
    // }

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'Location Service',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }



    print('hello');

// todo :- everytime you have to check weather a class a become non live or not
// todo:- endpoint for this has to be made
      //print('perm granted');
      if (!_isSmoothingInProgress) {
        stableCounter = 0;
        _smoothedLocation = null;
        await _startLocationSmoothing();
        _locationSubscription?.cancel();
        _countdownTimer?.cancel(); // Cancel the countdown timer manually
        _handleTimerExpiration(); // Trigger the check after the timer expires

        bool ch = smoothedLatitude != null && smoothedLongitude != null
            ? isPointInsideEllipse(centerX, centerY, semiMajorAxis, semiMinorAxis, smoothedLatitude!, smoothedLongitude!)
            : false; // or handle the case where one or both values are null

        print('checked if inside $ch');
        int s = await loadData('performedaction');
        s++;

        saveData('performedaction', s);
        print('s = ${s.toString()}');
        loadData('LocationChecks').then((value) {
          int? a = value;
          if (ch) {

              a++;

            saveData('LocationChecks', a);

          } else {

              saveData('LocationChecks', a);


          }
        });
String courseCode = await loadDataString("liveClass");
bool cl =  await classLiveorNot(courseCode);

        service.invoke(
          'update',
          {
            "actionper": s,
            "classliveornot":cl    // this returns weather class is live or not (fetch this in startcheks file0

          },
        );


    }




  });
}




















class MyApp extends StatelessWidget {
  const MyApp({super.key});


 Future <void> requestPermissions() async {
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
          theme: ThemeData(
              primaryColor : Color(0xff912C2E),
              hintColor:  Color(0xff912C2E),

        ),
          title: 'ASUR',

          home: SplashScreen(),

          debugShowCheckedModeBanner: false,
          );

      },
    );
  }
}

