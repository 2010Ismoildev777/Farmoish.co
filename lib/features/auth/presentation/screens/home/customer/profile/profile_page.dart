import 'package:farmoish/features/auth/presentation/components/button/profile_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Widget userIconWidget = Icon(Icons.person, color: Colors.white, size: 18);
    if (user != null && user.photoURL != null) {
      userIconWidget = CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user.photoURL!),
      );
    } else if (user != null &&
        user.displayName != null &&
        user.displayName!.isNotEmpty) {
      final firstLetter = user.displayName![0].toUpperCase();
      userIconWidget = CircleAvatar(
        radius: 60,
        backgroundColor: Colors.blue,
        child: Text(
          firstLetter,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F7F8),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 25),
        ),
        centerTitle: true,
        title: Text(
          'Мой Профиль',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Center(child: userIconWidget),
            SizedBox(height: 5),
            Text(
              user!.displayName ?? 'Нет Имени',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ),
            Text(
              user.phoneNumber ?? 'Нет Номера',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            ProfileButton(
              icon: Icons.email_outlined,
              title: 'Email',
              subTitle: user.email ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
