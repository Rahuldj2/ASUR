import 'package:Asur/Auth/login.dart';
import 'package:Asur/Auth/signup.dart';
import 'package:Asur/SplashScreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.t);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    systemNavigationBarColor: Color(0xff912C2E),
    statusBarColor:   Color(0xff080303)// Make navigation bar translucent
  ));
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'ASUR',

      home: SplashScreen(),

        debugShowCheckedModeBanner: false,
    );
  }
}

