import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final Color colorIcon;

  const MyForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
    this.colorIcon = const Color(0xFF3B3B3B)
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
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
  Widget build(BuildContext context){
    return TextFormField(
       controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: widget.colorIcon, width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: widget.colorIcon, width: 1.0),
          ),
          fillColor: Colors.transparent,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0x803B3B3B)
          ),
          prefixIcon: widget.icon != null ? Icon(widget.icon, color: widget.colorIcon) : null,
          suffixIcon: widget.obscureText ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off, 
              color: widget.colorIcon,
            ),
            onPressed: _toggleObscureText,
          ): null
        ),
        style: const TextStyle(
          fontSize: 14
        ),
    );
  }
}