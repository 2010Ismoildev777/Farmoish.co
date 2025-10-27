import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInNotifier extends StateNotifier<AsyncValue> {
  AppleSignInNotifier() : super(AsyncData([]));
  Future<void> signWithApple() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      state = AsyncLoading();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
        oauthCredential,
      );
      final user = userCredential.user;
      if (user == null) {
        state = const AsyncError(
          "Ошибка: пользователь не найден",
          StackTrace.empty,
        );
        return;
      }
      final userDoc = firebaseFirestore.collection("users").doc(user.uid);
      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'fullName': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'role': 'customer',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      state = AsyncData(userCredential);
    }  catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final appleSignInProvider = StateNotifierProvider<AppleSignInNotifier, AsyncValue>((ref) {
  return AppleSignInNotifier();
});