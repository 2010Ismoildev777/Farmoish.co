import 'package:farmoish/features/auth/data/datasource/firebase/auth/forgot/forgot_password.dart';
import 'package:farmoish/features/auth/presentation/components/button/my_button.dart';
import 'package:farmoish/features/auth/presentation/components/field/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  TextEditingController emailAddresController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final forgot = ref.watch(forgotPasswordProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          'Восстановление пароля',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Введите свой email, и мы отправим ссылку для восстановления пароля',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              MyTextField(
                controller: emailAddresController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Введите ваш email',
                icon: Icons.email,
              ),
              Spacer(),
              MyButton(
                onPressed: () async {
                  await ref
                      .read(forgotPasswordProvider.notifier)
                      .forgotPassword(emailAddresController.text.trim());
                  final state = ref.watch(forgotPasswordProvider);
                  state.when(
                    data: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ссылка для восстановления отправлена на ваш email ${emailAddresController.text}"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      emailAddresController.clear();
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
                child: forgot.isLoading
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Text(
                        'Отправить',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
