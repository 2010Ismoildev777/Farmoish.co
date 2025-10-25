import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class Registration extends StateNotifier<AsyncValue> {
  Registration() : super(AsyncData([]));
  Future<void> signUp(
    String fullName,
    String email,
    String password,
    String role,
  ) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      state = AsyncLoading();
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user!;
          await user.updateDisplayName(fullName);
          await firebaseFirestore.collection("users").doc(user.uid).set({
            'uid': user.uid,
            'fullName': fullName,
            'email': email,
            'role': role,
            'createdAt': FieldValue.serverTimestamp()
          });
          state = AsyncData(userCredential);
    } on FirebaseAuthException catch (e) {
      state = AsyncError(e.code, StackTrace.current);
    }
  }
}

final registrationProvider = StateNotifierProvider<Registration, AsyncValue>((ref) {
  return Registration();
});
