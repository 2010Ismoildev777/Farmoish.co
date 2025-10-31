import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OtpSendCodeNotifier extends StateNotifier<AsyncValue> {
  OtpSendCodeNotifier() : super(AsyncData([]));
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> verifyOtp(String verifycationId, String otp) async {
    try {
      state = AsyncLoading();
      final credential = PhoneAuthProvider.credential(
        verificationId: verifycationId,
        smsCode: otp,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      state = AsyncData(userCredential.user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final otpSendProvider = StateNotifierProvider<OtpSendCodeNotifier, AsyncValue>((
  ref,
) {
  return OtpSendCodeNotifier();
});
