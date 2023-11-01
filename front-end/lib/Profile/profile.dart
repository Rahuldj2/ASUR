import 'dart:typed_data';

import 'package:Asur/Global_Vairables/background_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String imageUrl = 'your_image_url_here'; // Replace with the actual image URL
  var downloadedImageData;


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
 User? user = FirebaseAuth.instance.currentUser;
      if (uid != null) {
        DocumentSnapshot userDocument = await usersCollection.doc(uid).get();

        if (userDocument.exists) {
          Map<String, dynamic> data = userDocument.data() as Map<String, dynamic>;

          // Process data as needed
          name = data['name'];
          email = data['email'];

 await _downloadImageFromStorage(user);
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

  Future<void> _downloadImageFromStorage(User? user) async {
    try {
      setState(() {
        loading = true;
      });




      if(user!=null) {
        Reference imageRef = _storage.ref().child('images').child(
            '${user.uid}.jpg');
        final Uint8List? imageData = await imageRef.getData();

        if (imageData != null) {
          setState(() {
            downloadedImageData = imageData;
            //img2 = Image.memory(downloadedImageData);
            loading = false;
          });
          print('Image downloaded and stored in memory.');
        } else {
          setState(() {
            loading = false;
          });
          print('Failed to download image.');
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error downloading image: $e');
    }


    if (downloadedImageData != null) {
      Uint8List encodedImage = Uint8List.fromList(downloadedImageData);

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
              "Profile",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),

      ),
      body: Stack(
        children: [
          GradientContainer(),
//           loading?Center(
//             child: Container(
//               padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.1),
//               child: const CircularProgressIndicator(
//                   color:Colors.white
//               ),
//             ),
//           ): Positioned(
//             top: height*0.15,
//             left: width/7,
//             right: width/7,
//             child: Container(
//
//               child: Column(
//                 children: [
//                   Text('Hey, $name',style: TextStyle(color: Colors.white,fontSize: 44,fontWeight: FontWeight.bold),),
// SizedBox(height: height*0.6,),
//                 //Logout
//                   InkWell(
//                     onTap: (){
//                       // manage change password on Tap
//                       logoutUser();
//                     },
//                     child: Container(
//                       height: 40,
//                       width: MediaQuery.sizeOf(context).width*0.76,
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(15)
//                       ),
//                       child: Center(child: Text('Logout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 14),)),
//                     ),
//                   )
//
//                   //Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
//                 ],
//               ),
//             ),
//           ),


         loading?SizedBox.shrink():Positioned(
           top: 40,
           left: 110,
           right: 110,
           child: ClipOval(
             child: Container(
               width: 130,
               height: 130,
               decoration: const ShapeDecoration(
                 color: Colors.white,
                 shape: CircleBorder(
                   side: BorderSide(
                     width: 2.5,
                     color: Color(0xFFE2E1FA),
                     style: BorderStyle.solid,
                   ),
                 ),
               ),
               child: downloadedImageData != null
                   ? Image.memory(Uint8List.fromList(downloadedImageData))
                   : Image.asset('assets/without background logo.png'), // Replace with your placeholder image asset path
             ),
           ),
         ),



          loading?  Center(
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1),
            child: const CircularProgressIndicator(
                color:Colors.white
            ),
          ),
        ):Positioned(
              top: 190,
              left: 70,
              right:70,
              child: Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height*0.78,
                  //color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 26),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                      Text('Computer Science and Engineering',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 23),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                      Text('2025 Batch',style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w600,fontSize: 23),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                      Text('Under Process',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 23),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                      // Text('Accomodation',style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w600,fontSize: 25),),
                      // SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                      // Text('3 Nights',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 23),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

                      InkWell(
                        onTap: (){
                          // manage change password on Tap
                          logoutUser();
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width*0.76,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: Text('Logout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 14),)),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
