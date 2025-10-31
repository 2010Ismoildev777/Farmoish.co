import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  const ProfileButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          foregroundColor: Colors.black,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF6F7F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(subTitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_sharp, size: 25),
          ],
        ),
      ),
    );
  }
}
