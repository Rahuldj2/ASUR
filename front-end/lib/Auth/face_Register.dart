import 'dart:io';

import 'package:Asur/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../Home/homepage.dart';

class FaceRegister extends StatefulWidget {
  final User user; // Pass the user object from Firebase Authentication.

  const FaceRegister({Key? key, required this.user}) : super(key: key);

  @override
  _FaceRegisterState createState() => _FaceRegisterState();
}

class _FaceRegisterState extends State<FaceRegister> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  late String imageUrl;
  bool loading = false;

  Future<void> _uploadImageAndSaveToFirestore() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) {
      // Handle if no image is selected.
      return;
    }
setState(() {
  loading= true;
});
    final Reference storageReference = _storage.ref().child('images/${widget.user.uid}.jpg');

    try {
      await storageReference.putFile(File(pickedImage.path));
      imageUrl = await storageReference.getDownloadURL();

      // Update Firestore document with the image URL.
      await _firestore.collection('Users').doc(widget.user.uid).update({
       // 'name': widget.user.,
        'email': widget.user.email,
        'url': imageUrl,
      });

      // Navigate to the homepage or any desired page.
      setState(() {
        loading= false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>LoginScreen(),
        ),
      );
    } catch (error) {
      // Handle any errors that occur during image upload or Firestore update.
      setState(() {
        loading= false;
      });
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff912C2E),
        title: Text('Face Register'),
      ),
      body:   loading?Center(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1),
          child: const CircularProgressIndicator(
              color:Colors.black
          ),
        ),
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                _uploadImageAndSaveToFirestore();
              },

              child: Container(
                  height: height*0.08,
                  width: width*0.65,
                  decoration: BoxDecoration(
                    color: Colors.black,

                    borderRadius:
                    BorderRadius.circular(15),

                  ),
                  child: Text('Capture and Upload Image',style: TextStyle(color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }
}




