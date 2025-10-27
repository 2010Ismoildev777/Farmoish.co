import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInNotifier extends StateNotifier<AsyncValue> {
  GoogleSignInNotifier() : super(AsyncData([]));
  Future<void> googleSignIn() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      state = AsyncLoading();
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) {
        state = const AsyncError('Ошибка: пользователь не найден', StackTrace.empty);
        return;
      }
      final userDoc = firebaseFirestore.collection("users").doc(user.uid);
      final snapshot = await userDoc.get();
      if(!snapshot.exists) {
        await userDoc.set({
          'fullName': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'role': 'customer',
          'createdAt': FieldValue.serverTimestamp()
        });
      }
      state = AsyncData(userCredential);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final googleSignInProvider =
    StateNotifierProvider<GoogleSignInNotifier, AsyncValue>((ref) {
      return GoogleSignInNotifier();
    });
