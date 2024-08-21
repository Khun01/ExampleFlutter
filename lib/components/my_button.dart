import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget{

  final Function()? onTap;
  final String buttonText;
  final Color color;
  final Color textColor;

  const MyButton({
    super.key, 
    required this.onTap, 
    required this.buttonText, 
    this.color = const Color(0xFF3B3B3B),
    this.textColor = const Color(0xFFF6F6F6)
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.nunito(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}