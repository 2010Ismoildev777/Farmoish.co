import 'package:farmoish/map/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide TextStyle, Icon;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Widget userIconWidget = Icon(Icons.person, color: Colors.white, size: 18);
    if (user != null && user.photoURL != null) {
      userIconWidget = CircleAvatar(
        backgroundImage: NetworkImage(user.photoURL!),
      );
    } else if (user != null &&
        user.displayName != null &&
        user.displayName!.isNotEmpty) {
      final firstLetter = user.displayName![0].toUpperCase();
      userIconWidget = CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          firstLetter,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: MapPage(userIconWidget: userIconWidget),
    );
  }
}
