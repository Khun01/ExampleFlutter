import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool obscureText;

  @override
  void initState(){
    super.initState();
    obscureText = widget.obscureText;
  }
  void _toggleObscureText(){
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        hintText: widget.hintText,
        prefixIcon: widget.icon,
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off
          ),
          onPressed: _toggleObscureText,
        ): null
      ),
    );
  }
}