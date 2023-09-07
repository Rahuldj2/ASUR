import 'package:flutter/material.dart';

import '../Global_Vairables/background_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {


    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _nameController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Your background gradient container
          GradientContainer(),
          // ClipRect to hide upper half of the image
          ClipRect(
            child: Align(
              alignment: FractionalOffset(0.5, -0.36), // Adjust the offset here
              child: Container(
                height: height * 0.5, // Display only half of the image
                child: Stack(
                  children: [
                    Column(
                      children: [
                        ClipRect(
                          child: Align(
                            alignment: FractionalOffset(0.5, -0.36),
                            child: Opacity(
                              opacity: 1,
                              child: Image.asset(
                                'assets/without background logo.png',
                                height: height * 0.3,
                                width: width * 0.6,
                              ),
                            ),
                          ),
                        ),
                        // Add other widgets here
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: height*0.15,
            left: width/5,
            right: width/5,
            child: Container(

              child: Column(
                children: [
                  Text('Create new',style: TextStyle(color: Colors.white,fontSize: 44,fontWeight: FontWeight.bold),),
                  SizedBox(height: height*0.00001,),
                  Text('Account',style: TextStyle(color: Colors.white,fontSize: 44,fontWeight: FontWeight.bold),),
                  SizedBox(height: height*0.001,),
                  Text('Sign up to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),

                  SizedBox(height: height*0.1,),
                  //Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                ],
              ),
            ),
          ),


          Positioned(
            top: height*0.4,
            left: width/9,
            right: width/8,
            child: Container(

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
                    onTap: (){
                      // manage on tap on Sign upButton
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
                      child: Center(child: Text('Already Registered? Log in here',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w100),))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
