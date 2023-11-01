import 'dart:convert';
import 'package:Asur/Auth/face_Register.dart';
import 'package:http/http.dart' as http;
import 'package:Asur/Auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../Global_Vairables/background_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  late User user;
  late final String name ;
  late final String email ;
  late FToast  flutterToast;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    flutterToast= FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    flutterToast.init(context);
  }






  Future<void> addStudent() async {
    String fullName = _nameController.text;
    List<String> nameParts = fullName.split(' ');

    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    String email = _emailController.text;
    String dateStr = '2002-10-17'; // Replace with your date string
    DateTime date = DateTime.parse(dateStr);
    // Format the date as 'MM/dd/yyyy' (you can change the format as needed)
 //   String formattedDate = DateFormat('MM/dd/yyyy').format(date);
    final Uri uri = Uri.parse('http://10.6.9.160:3000/api/signUpDetails');
    final Map<String, dynamic> data = {
      'FirstName': firstName,  // Modify the keys to match the API's expected keys
      'LastName': lastName,
      'NetId': email, // Add the last name if needed
      'DOB': '2002-10-17',        // Add the date of birth if needed
    // Assuming NetId corresponds to the email
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          // Student added successfully, you can handle the success here
          print('Student added successfully');
        } else {
          // Handle the case where adding the student failed
          print('Failed to add student');
        }
      } else {
        // Handle the case where the server returned an error
        print('Error at a: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any other errors that may occur during the HTTP request
      print('Error at a: $e');
    }
  }


// function to show toast message for verification link
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
  // Function to create a new user in Firebase Authentication and store additional info in Firestore
  Future<User?> signUpAndStoreUserData() async {

    setState(() {
      loading= true;
    });
    try {
      // Create a new user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Send email verification link
      // await userCredential.user!.sendEmailVerification();

      // Get the newly created user's UID
      user= userCredential.user!;
      String userId = userCredential.user!.uid;

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
      });

      // TODO: uncomment the  addStudent function for storing data in sql

      addStudent();

      // Navigate to the home screen or perform other actions
      return user;
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } catch (e) {
      // Handle errors
      _showToast(e.toString());
      print(e);
    }
    setState(() {
      // Show a toast message
      _showToast("Verification link has been sent to your email");
      loading=false;
    });
  }



  @override
  Widget build(BuildContext context) {



    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
// Check if the keyboard is open
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                // Your background gradient container
                GradientContainer(),
                // ClipRect to hide upper half of the image
              !loading?  ClipRect(
                  child: Align(
                    alignment: FractionalOffset(0.5, -0.35), // Adjust the offset here
                    child: Container(
                      height: height * 0.5, // Display only half of the image
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Opacity(
                                opacity: 1,
                                child: Image.asset(
                                  'assets/without background logo.png',
                                  height: height * 0.3,
                                  width: width * 0.6,
                                ),
                              ),
                              // Add other widgets here
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ):SizedBox(height: 0,),

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
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(

                      child: Column(
                        children: [
                          Text('Create new',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                          SizedBox(height: height*0.00001,),
                          Text('Account',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                          SizedBox(height: height*0.002,),
                          InkWell(
                              onTap: (){
                                //   go to Login page
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>LoginScreen()));

                              },
                              child: Text('Already Registered? Login in here',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300),)),

                          SizedBox(height: height*0.1,),
                          //Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ),
                  ),
                ),


                loading?Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: const CircularProgressIndicator(
                        color:Colors.white
                    ),
                  ),
                ): Positioned(
                  top: height*0.4,
                  left: width/9,
                  right: width/8,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.manual,
                    reverse: true,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        // NAME FIELD
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('NAME ',style: TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                        SizedBox(height: height*0.01,),
                        // Email Field
                        Container(

                          height: height*0.06,

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Color(0xffA3A2A2),
                            border: Border.all(
                                width: 2,
                                color: Colors.black),
                            borderRadius:
                            BorderRadius.circular(13),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: TextFormField(

                              controller: _nameController,



                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                fillColor:Color(0xffA3A2A2),
                                filled: true,
                                // errorStyle: TextStyle(height: 0.5),
                                hintStyle: TextStyle(color: Color(0xB310100E)),
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    borderSide:  BorderSide.none

                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),




                        // EMAIL
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('EMAIL ',style: TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                        SizedBox(height: height*0.01,),
                        // Email Field
                        Container(

                          height: height*0.06,

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Color(0xffA3A2A2),
                            border: Border.all(
                                width: 2,
                                color: Colors.black),
                            borderRadius:
                            BorderRadius.circular(13),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: TextFormField(

                              controller: _emailController,



                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                fillColor:Color(0xffA3A2A2),
                                filled: true,
                                // errorStyle: TextStyle(height: 0.5),
                                hintStyle: TextStyle(color: Color(0xB310100E)),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    borderSide:  BorderSide.none

                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('PASSWORD ',style: TextStyle(color: Colors.white,fontSize: 15),),
                        ),
                        SizedBox(height: height*0.01,),
                        // Email Field
                        Container(

                          height: height*0.06,

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Color(0xffA3A2A2),
                            border: Border.all(
                                width: 2,
                                color: Colors.black),
                            borderRadius:
                            BorderRadius.circular(13),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: TextFormField(

                              controller:_passwordController,

                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                fillColor:Color(0xffA3A2A2),
                                filled: true,
                                // errorStyle: TextStyle(height: 0.5),
                                hintStyle: TextStyle(color: Color(0xB310100E)),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    borderSide:  BorderSide.none

                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height*0.1,),
                        // Sign Up Button
                        InkWell(
                          onTap: () async {
                            User? newUser = await signUpAndStoreUserData();
                            if (newUser != null) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FaceRegister(user: newUser)));
                            }
                          },
                          child: Container(

                            height: height*0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,

                              borderRadius:
                              BorderRadius.circular(15),

                            ),
                            child: Center(child: Text("Sign Up",style: TextStyle(decoration:TextDecoration.underline
                                ,color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),

                          ),
                        ),

                        SizedBox(height: height*0.005,),
                        InkWell(
                            onTap: (){
                              // navigate to Sign Up

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Live in ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w100),),
                                Text('PRESENT.',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
