import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:Asur/Location_Check/StartChecks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Asur/Navigator/bottom_navigation.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FaceApp extends StatefulWidget {
  final String coursecode;

  FaceApp(this.coursecode);

  @override
  _FaceAppState createState() => _FaceAppState();
}

class _FaceAppState extends State<FaceApp>{

  List<CameraDescription> cameras = [];
  late CameraDescription selectedCamera;
  late CameraController cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    selectedCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      selectedCamera,
      ResolutionPreset.high,
    );

    await cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }


  final ImagePicker _picker = ImagePicker();

  bool loading = false;
  bool checked = false;
  var image1 = new Regula.MatchFacesImage();
  var image2 = new Regula.MatchFacesImage();
  var img1 = Image.asset('assets/portrait.png');
  var img2 = Image.asset('assets/portrait.png');
  String _similarity = "nil";
  late double similarper=0;
  String _liveness = "nil";
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String imageUrl = 'your_image_url_here'; // Replace with the actual image URL
  var downloadedImageData;


  @override
  void initState() {
    super.initState();

    initPlatformState();
    _downloadImageFromStorage();
    initCamera();

    const EventChannel('flutter_face_api/event/video_encoder_completion')
        .receiveBroadcastStream()
        .listen((event) {
      var completion =
      Regula.VideoEncoderCompletion.fromJson(json.decode(event))!;
      print("VideoEncoderCompletion:");
      print("    success:  ${completion.success}");
      print("    transactionId:  ${completion.transactionId}");
    });
    const EventChannel('flutter_face_api/event/onCustomButtonTappedEvent')
        .receiveBroadcastStream()
        .listen((event) {
      print("Pressed button with id: $event");
    });
    const EventChannel('flutter_face_api/event/livenessNotification')
        .receiveBroadcastStream()
        .listen((event) {
      var notification =
      Regula.LivenessNotification.fromJson(json.decode(event));
      print("LivenessProcessStatus: ${notification!.status}");
    });
  }

  Future<void> initPlatformState() async {
    Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });
  }




// Function to get the details of the logged-in user
  Future<User?> getCurrentUser() async {
    try {
      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is logged in, return the user object
        return user;
      } else {
        // User is not logged in
        return null;
      }
    } catch (e) {
      // Handle any potential errors
      print("Error getting current user: $e");
      return null;
    }
  }



  showAlertDialog(BuildContext context, bool first, [downloadedImage])




  async {

  Regula.FaceSDK.startLiveness().then((value) {
      var result = Regula.LivenessResponse.fromJson(json.decode(value));
      if (result!.bitmap == null) return;
      setImage(true, base64Decode(result.bitmap!.replaceAll("\n", "")),
          Regula.ImageType.LIVE);

    });




   // Navigator.pop(context);




    // Use image_picker to capture an image
    // final XFile? capturedImage = await _picker.pickImage(
    //     source: ImageSource.camera);
    //
    // if (capturedImage != null) {
    //   // Load the captured image and set it
    //   Uint8List imageBytes = await capturedImage
    //       .readAsBytes();
    //   setImage(first, imageBytes, Regula.ImageType.LIVE);
    // }


  }



  setImage(bool first, Uint8List? imageFile, int type) {
    if (imageFile == null) {
      print('set image null');
      return;
    }
    setState(() => _similarity = "nil");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      setState(() {

        _liveness = "nil";
      });
    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;

    }
  }


  Future<void> _downloadImageFromStorage() async {
    try {
      setState(() {
        loading = true;
      });
      User? user = await getCurrentUser();
      if (user != null) {
        print("User ID: ${user.uid}");
        print("User Email: ${user.email}");
        // You can access other user properties like displayName, photoURL, etc.
      } else {
        print("No user is currently logged in.");
      }


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
      setImage(
          false,
          encodedImage,
          Regula.ImageType.PRINTED);
    }
  }


  clearResults() {
    setState(() {
      img1 = Image.asset('assets/portrait.png');
      // img2 = Image.asset('assets/portrait.png');
      _similarity = "nil";
      _liveness = "nil";
    });
    image1 = new Regula.MatchFacesImage();
    image2 = new Regula.MatchFacesImage();
  }

  matchFaces() {
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == "") {
      print('images  are null');
      setState(() {
        loading= false;
      });
      return;
    }
    setState(() {
      loading = true;
    });
    // setState(() => _similarity = "Processing...");
    var request = new Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75)
          .then((str) {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() {
          similarper = split!.matchedFaces.length > 0
              ? (split.matchedFaces[0]!.similarity! * 100) : 0;
          loading = false;
          print('similar per ${similarper.toString()}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultAnimation(similarper>98?true:false),
            ),
          );

          // After 4 seconds, pop out of the ResultAnimation screen
          Future.delayed(Duration(seconds: 4), () {
            Navigator.pop(context);
            if(similarper>98) {
              saveData("FaceMatch", true);
              saveDatastring("liveClass", widget.coursecode);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StartChecks(),
                ),
              );
            }else{
              saveData("FaceMatch", false);
            }
          });
        });


      });
    });
    checked= true;
    // After successful matching



  }

  Future<void> saveData(String key, bool match) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, match);
  }
  Future<void> saveDatastring(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }



  Widget createButton(String text, VoidCallback onPress) =>
      Container(
        // ignore: deprecated_member_use
        child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
            onPressed: onPress,
            child: Text(text)),
        width: 250,
      );

  Widget createImage(image, VoidCallback onPress) =>
      Material(
          child: InkWell(
            onTap: onPress,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(height: 150, width: 150, image: image),
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading
          ? Center(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1),
          child: const CircularProgressIndicator(
            color: Color.fromARGB(255, 8, 23, 120),
          ),
        ),
      )
          :
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                showAlertDialog(context, true);
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Capture Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 34),
            InkWell(
              onTap: () async {
                // Show circular progress indicator
                setState(() {
                  loading = true;
                });

                // Perform the matchFaces operation
                matchFaces();

                // Delay to simulate processing time
               // await Future.delayed(Duration(seconds: 2));

                // Hide circular progress indicator




                if (similarper > 98) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BottomNavigation(1),
                    ),
                  );
                }
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Authenticate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 22),
            SizedBox(height: 16), // Add some spacing

            // Wrap the content in a Visibility widget


            // Circular progress indicator
            if (loading)
              CircularProgressIndicator(
                value: null,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),

            // Animated tick or cross based on similarity



          ],
        ),
      ),
    );
  }

}












class ResultAnimation extends StatefulWidget {
  final bool isSuccessful; // Indicates whether the animation should show success or failure

  ResultAnimation(this.isSuccessful);

  @override
  _ResultAnimationState createState() => _ResultAnimationState();
}

class _ResultAnimationState extends State<ResultAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Create and start the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 550),
    )..forward();

    // Create an opacity animation tween
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    // Add a listener to restart the animation when it completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Icon(
                    widget.isSuccessful
                        ? Icons.check_circle // Green tick
                        : Icons.cancel, // Red cross
                    color: widget.isSuccessful ? Colors.green : Colors.red,
                    size: 100.0,
                  ),
                );
              },
            ),
            SizedBox(height: 4,),
            Text(
              widget.isSuccessful ? "Authenticated" : "Not Authorized",
              style: TextStyle(
                color: widget.isSuccessful ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
