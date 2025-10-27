import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ForgotPasswordNotifier extends StateNotifier<AsyncValue> {
  ForgotPasswordNotifier() : super(AsyncData([]));
  Future<void> forgotPassword(String email) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (email.isEmpty) {
      state = AsyncError("Введите email", StackTrace.current);
      return;
    }
    try {
      state = AsyncLoading();
      await firebaseAuth.sendPasswordResetEmail(email: email);
      state = AsyncData(null);
    } on FirebaseException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
        msg = 'Введите корректный email';
        break;
        case 'user-not-found':
        msg = 'Аккаунт с таким email не найден';
        break;
        default:
        msg = 'Произошла ошибка. Попробуйте снова.';
      }
      state = AsyncError(msg, StackTrace.current);
    }
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, AsyncValue>((ref) {
      return ForgotPasswordNotifier();
    });
