import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  const MyTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Color(0xFF577FA0),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(widget.icon, color: Color(0xFF577FA0),),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF577FA0),
                ),
              )
            : SizedBox(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF577FA0), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF577FA0), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
