import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //#7A2529--> bottom   #080303--> mid      #050303--> top
             // Color(0xff050303),
             // Color(0xff7A2529),
              Color(0xff080303),
              Color(0xff912C2E)

            ],
            stops: [ 0.66, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
      ),
    );
  }
}




class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height * 1.2, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0); // Add this line to close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}