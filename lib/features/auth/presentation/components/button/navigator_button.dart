import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Function onPressed;
  final String image;
  final Color? imageColor;
  final Color sideColor;
  final String text;
  final Color textColor;
  const NavigatorButton({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    required this.image,
    this.imageColor,
    this.sideColor = Colors.transparent,
    this.textColor = Colors.white,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          side: BorderSide(
            color: sideColor,
            width: 2
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, color: imageColor, width: 30),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
