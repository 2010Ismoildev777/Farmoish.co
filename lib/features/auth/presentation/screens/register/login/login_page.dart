import 'package:farmoish/features/auth/data/datasource/firebase/auth/login/login.dart';
import 'package:farmoish/features/auth/presentation/components/button/my_button.dart';
import 'package:farmoish/features/auth/presentation/components/field/my_text_field.dart';
import 'package:farmoish/features/auth/presentation/screens/register/forgot/forgot_password_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailAddresController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('images/lottie/car.json', width: 150),
                    Text(
                      'Farmoish',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Войдите в аккаунт',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Адрес электронной почты',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    MyTextField(
                      controller: emailAddresController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Введите ваш email',
                      icon: Icons.email,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Создайте пароль',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    MyTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Введите пароль',
                      isPassword: true,
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Забыли пароль?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onPressed: () async {
                        await ref
                            .read(loginProvider.notifier)
                            .login(
                              emailAddresController.text.trim(),
                              passwordController.text.trim(),
                              context,
                            );
                        final state = ref.watch(loginProvider);
                        state.when(
                          data: (data) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Вход выполнен успешно"),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          error: (error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          loading: () {},
                        );
                      },
                      child: login.isLoading
                          ? CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                              'Войти в аккаунт',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Нет аккаунта? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
