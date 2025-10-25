import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  const MyButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF138AEC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
}
