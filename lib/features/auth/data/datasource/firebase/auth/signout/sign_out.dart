import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutNotifier extends StateNotifier<AsyncValue> {
  SignOutNotifier() : super(AsyncData([]));
  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      state = AsyncLoading();
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      state = AsyncData(null);
    }
    catch(e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final signOutProvider = StateNotifierProvider<SignOutNotifier, AsyncValue>((ref) {
  return SignOutNotifier();
});
