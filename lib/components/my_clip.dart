import 'package:flutter/material.dart';

class MyClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    final Path path = Path();
    final double cornerRadius = 100; // Radius of the rounded corner
    final double extendedWidth = 400; // Width of the extended part of the rounded corner
    final double extendedHeight = 50; // Height of the extended part of the rounded corner

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - extendedHeight); // Position for the extended rounded corner
    
    // Create a long rounded corner effect
    path.arcToPoint(
      Offset(size.width - extendedWidth, size.height),
      radius: Radius.circular(cornerRadius),
      clockwise: false,
    );
    path.lineTo(0, size.height); // Move to bottom-left corner
    path.close();

    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}