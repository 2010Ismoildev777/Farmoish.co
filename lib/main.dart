import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmoish/features/auth/presentation/screens/home/courier/courier_home_page.dart';
import 'package:farmoish/features/auth/presentation/screens/home/customer/map/map_screen.dart';
import 'package:farmoish/features/auth/presentation/screens/register/registration/registration_role_selection.dart';
import 'package:farmoish/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> getUserRole() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) return null;
    final userDoc = await firebaseFirestore.collection("users").doc(uid).get();
    return userDoc.data()?['role'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firebaseAuth.currentUser == null
          ? RegistrationRoleSelection()
          : FutureBuilder<String?>(
              future: getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(child: CupertinoActivityIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(child: Text('Ошибка: ${snapshot.error}')),
                  );
                } else {
                  final role = snapshot.data;
                  return role == 'customer'
                      ? MapScreen()
                      : CourierHomePage();
                }
              },
            ),
    );
  }
}
