import 'package:Asur/Auth/signup.dart';
import 'package:Asur/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global_Vairables/background_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;
  late FToast  flutterToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterToast= FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    flutterToast.init(context);
  }


  // Function to Show toast
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



  //--------------------------------------------FIREBASE LOGIC--------------------------------------------
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> setLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('LogedIn', true);
  }

  Future<void> loginUser() async {
    try {
      setState(() {
        loading= true;
      });
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text, // Use email as the username
        password: _passwordController.text,
      );

      // Check if the user's email is verified
      if (userCredential.user != null ) {
        // Successfully logged in and email is verified
        setLoggedIn();

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Profile()));
        setState(() {
          loading= false;
        });
      } else {
        // Email is not verified

        _showToast("Please verify your email before logging in.");
        setState(() {
          loading= false;
        });
      }

    } catch (e) {
      print("Error during login: $e");
      _showToast("Login failed. Please check your credentials.");
      setState(() {
        loading= false;
      });

    }
  }






  @override
  Widget build(BuildContext context) {



    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                // Your background gradient container
                GradientContainer(),
                // ClipRect to hide upper half of the image
               !loading? ClipRect(
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
                  child: Container(

                    child: Column(
                      children: [
                        Text('Login',style: TextStyle(color: Colors.white,fontSize: 44,fontWeight: FontWeight.bold),),
                        SizedBox(height: height*0.003,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (_)=>SignUpScreen()));
                          },
                            child: Text("Don't have a account? Sign Up",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300),)),

                        SizedBox(height: height*0.1,),
                        //Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                      ],
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
                  child: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
obscureText: true,
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
                        // Login Button
                        InkWell(
                          onTap: (){
                            // manage on tap on Log in Button
                            loginUser();
                          },
                          child: Container(

                            height: height*0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,

                              borderRadius:
                              BorderRadius.circular(15),

                            ),
                            child: Center(child: Text("Log In",style: TextStyle(decoration:TextDecoration.underline
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
