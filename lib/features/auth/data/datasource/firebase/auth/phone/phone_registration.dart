import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PhoneRegistrationNotifier extends StateNotifier<AsyncValue> {
  PhoneRegistrationNotifier() : super(AsyncData([]));
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> sendCode(
    String phoneNumber,
    Function(String verifycationId) onCodeSent,
    Function(String message) onError,
  ) async {
    try {
      state = AsyncLoading();
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(e.message ?? 'Ошибка верификации');
        },
        codeSent: (String verifycationId, int? forceResendingToken) {
          onCodeSent(verifycationId);
        },
        codeAutoRetrievalTimeout: (_) {},
      );
      state = AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final phoneRegistrationProvider = StateNotifierProvider<PhoneRegistrationNotifier, AsyncValue>((ref) {
  return PhoneRegistrationNotifier();
});
