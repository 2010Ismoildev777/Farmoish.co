import 'package:farmoish/features/auth/data/datasource/firebase/auth/register/apple_sign_in.dart';
import 'package:farmoish/features/auth/data/datasource/firebase/auth/register/google_sign_in.dart';
import 'package:farmoish/features/auth/data/datasource/firebase/auth/register/registration.dart';
import 'package:farmoish/features/auth/presentation/components/button/my_button.dart';
import 'package:farmoish/features/auth/presentation/components/button/navigator_button.dart';
import 'package:farmoish/features/auth/presentation/components/field/my_text_field.dart';
import 'package:farmoish/features/auth/presentation/screens/home/customer/customer_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistratitonCustomerPage extends ConsumerStatefulWidget {
  final String selectedRole;
  const RegistratitonCustomerPage({super.key, required this.selectedRole});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistratitonCustomerPageState();
}

class _RegistratitonCustomerPageState
    extends ConsumerState<RegistratitonCustomerPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddresController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final register = ref.watch(registrationProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 25),
        ),
        centerTitle: true,
        title: Text(
          'Регистрация клиента',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Полное Имя',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              MyTextField(
                controller: fullNameController,
                keyboardType: TextInputType.name,
                hintText: 'Введите ваше полное имя',
                icon: Icons.person,
              ),

              SizedBox(height: 20),
              Text(
                'Адрес электронной почты',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              MyTextField(
                controller: emailAddresController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Введите ваш email',
                icon: Icons.email,
              ),
              SizedBox(height: 20),
              Text(
                'Создайте пароль',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              MyTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Введите пароль',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20),
              Text(
                'Подтвердите пароль',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              MyTextField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Повторите пароль',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20),
              MyButton(
                onPressed: () async {
                  await ref
                      .read(registrationProvider.notifier)
                      .signUp(
                        fullNameController.text.trim(),
                        emailAddresController.text.trim(),
                        passwordController.text.trim(),
                        confirmPasswordController.text.trim(),
                        widget.selectedRole,
                      );
                  final state = ref.watch(registrationProvider);
                  state.when(
                    data: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Регистрация прошла успешно'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      fullNameController.clear();
                      emailAddresController.clear();
                      passwordController.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomerHomePage(),
                        ),
                        (route) => false,
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
                child: register.isLoading
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    '  Или войдите через  ',
                    style: TextStyle(color: Color(0xFF577FA0)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),
              NavigatorButton(
                backgroundColor: Colors.white,
                sideColor: Colors.black,
                textColor: Colors.black,
                onPressed: () async {
                  await ref.read(googleSignInProvider.notifier).googleSignIn();
                  final state = ref.watch(googleSignInProvider);
                  state.when(
                    data: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Вы успешно вошли через Google'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomerHomePage(),
                        ),
                        (route) => false,
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
                image: 'images/image/google.png',
                text: 'Продолжить с Google',
              ),
              SizedBox(height: 20),
              NavigatorButton(
                backgroundColor: Colors.white,
                sideColor: Colors.black,
                textColor: Colors.black,
                onPressed: () async {
                  await ref.read(appleSignInProvider.notifier).signWithApple();
                  final state = ref.watch(appleSignInProvider);
                  state.when(
                    data: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Вы успешно вошли через Apple"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomerHomePage(),
                        ),
                        (route) => false,
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
                image: 'images/image/apple.png',
                text: 'Продолжить с Apple',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
