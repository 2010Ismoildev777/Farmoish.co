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
    String confirmPassword,
    String role,
  ) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (email.isEmpty &&
          fullName.isEmpty &&
          password.isEmpty &&
          confirmPassword.isEmpty) {
        state = AsyncError(
          'Пожалуйста, заполните все поля',
          StackTrace.current,
        );
        return;
      }
      if (fullName.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
        state = AsyncError(
          'Пожалуйста, введите имя и пароль',
          StackTrace.current,
        );
        return;
      }
      if (email.isEmpty) {
        state = AsyncError('Пожалуйста, введите email', StackTrace.current);
        return;
      }
      if (fullName.isEmpty) {
        state = AsyncError('Пожалуйста, введите имя', StackTrace.current);
        return;
      }
      if (password.isEmpty && confirmPassword.isEmpty) {
        state = AsyncError('Пожалуйста, введите пароль', StackTrace.current);
        return;
      }
      if (password.length < 6) {
        state = AsyncError(
          'Пароль слишком короткий. Минимум 6 символов',
          StackTrace.current,
        );
        return;
      }
      if (password != confirmPassword) {
        state = AsyncError(
          "Пожалуйста, введите одинаковые пароли",
          StackTrace.current,
        );
        return;
      }
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
        'createdAt': FieldValue.serverTimestamp(),
      });
      state = AsyncData(userCredential);
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = 'Некорректный формат электронной почты';
          break;
        case 'email-already-in-use':
          msg = 'Эта почта уже зарегистрирована';
          break;
        case 'weak-password':
          msg = 'Слишком слабый пароль';
          break;
        case 'operation-not-allowed':
          msg = 'Регистрация через email сейчас недоступна';
          break;
        case 'user-disabled':
          msg = 'Аккаунт этого пользователя отключён';
          break;
        default:
          msg = 'Произошла неизвестная ошибка. Повторите попытку';
          break;
      }
      state = AsyncError(msg, StackTrace.current);
    }
  }
}

final registrationProvider = StateNotifierProvider<Registration, AsyncValue>((
  ref,
) {
  return Registration();
});
