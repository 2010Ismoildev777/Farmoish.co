import 'package:farmoish/features/auth/data/datasource/firebase/auth/phone/phone_registration.dart';
import 'package:farmoish/features/auth/presentation/components/button/my_button.dart';
import 'package:farmoish/features/auth/presentation/components/field/my_text_field.dart';
import 'package:farmoish/features/auth/presentation/screens/register/phone/otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneRegistration extends ConsumerStatefulWidget {
  const PhoneRegistration({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhoneRegistrationState();
}

class _PhoneRegistrationState extends ConsumerState<PhoneRegistration> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final phone = ref.watch(phoneRegistrationProvider);
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
          'Регистрация Телефона',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              MyTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hintText: '+992',
                icon: Icons.phone,
              ),
              Spacer(),
              MyButton(
                onPressed: () async {
                  await ref
                      .read(phoneRegistrationProvider.notifier)
                      .sendCode(
                        phoneController.text.trim(),
                        (verificationId) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => OtpPage()),
                          );
                        },
                        (msg) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                },
                child: phone.isLoading
                    ? CupertinoActivityIndicator()
                    : Text(
                        'Отправить код',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.white,
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
