import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmoish/features/auth/presentation/screens/home/courier/courier_home_page.dart';
import 'package:farmoish/features/auth/presentation/screens/home/customer/map/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LoginNotifier extends StateNotifier<AsyncValue> {
  LoginNotifier() : super(AsyncData([]));
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (email.isEmpty && password.isEmpty) {
      state = AsyncError('Пожалуйста, заполните все поля', StackTrace.current);
      return;
    }
    if (email.isEmpty) {
      state = AsyncError('Пожалуйста, введите email', StackTrace.current);
      return;
    }
    if (password.isEmpty) {
      state = AsyncError('Пожалуйста, введите пароль', StackTrace.current);
      return;
    }
    try {
      state = AsyncLoading();
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user?.uid;
      final userDoc = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .get();
      final role = userDoc.data()?['role'];
      if (role == 'customer') {
        print('User role: $role');
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => MapScreen()),
          (route) => false,
        );
      } else if (role == 'courier') {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => CourierHomePage()),
          (route) => false,
        );
      }
      state = AsyncData(userCredential);
    } on FirebaseException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-credential':
          msg = 'Неверные данные учетной записи';
          break;
        case 'invalid-email':
          msg = 'Неверный формат email';
          break;
        default:
          msg = 'Произошла ошибка. Попробуйте ещё раз';
          break;
      }
      state = AsyncError(msg, StackTrace.current);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue>((ref) {
  return LoginNotifier();
});
