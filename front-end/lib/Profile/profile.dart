import 'package:Asur/Global_Vairables/background_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  String name="";
  String email="";
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  late FToast  flutterToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterToast= FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    flutterToast.init(context);
    fetchUserData();

  }

  _showToast(String s) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child:Row(
        children: [
          Icon(Icons.mail),
          SizedBox(width: 6.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width, // Adjust as needed
                  child: Text(
                    s, // Your text here
                    maxLines: 5,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );


    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );

    // Custom Toast Position
    flutterToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 5),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }


  Future<void> fetchUserData() async {
    setState(() {
      loading = true;
    });

    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        DocumentSnapshot userDocument = await usersCollection.doc(uid).get();

        if (userDocument.exists) {
          Map<String, dynamic> data = userDocument.data() as Map<String, dynamic>;

          // Process data as needed
          name = data['name'];
          email = data['email'];


          print('Name: $name, Email: $email');
        } else {
          print('User document does not exist');
        }
      } else {
        print('User is not signed in');
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      _showToast("Error fetching data");
      print('Error fetching data: $e');
    }
  }



  Future<void> logoutUser()async{
    await FirebaseAuth.instance.signOut().then((value) async {//delete uid from getstorage.

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('LogedIn', false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
            (route) => false, // Remove all routes until now.
      );
    });
  }






  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          GradientContainer(),
          loading?Center(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: const CircularProgressIndicator(
                  color:Colors.white
              ),
            ),
          ): Positioned(
            top: height*0.15,
            left: width/7,
            right: width/7,
            child: Container(

              child: Column(
                children: [
                  Text('$name',style: TextStyle(color: Colors.white,fontSize: 44,fontWeight: FontWeight.bold),),
SizedBox(height: height*0.1,),
                //Logout
                  InkWell(
                    onTap: (){
                      // manage change password on Tap
                      logoutUser();
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.sizeOf(context).width*0.76,
                      decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text('Logout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 14),)),
                    ),
                  )

                  //Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
