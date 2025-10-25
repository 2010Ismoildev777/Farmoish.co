import 'package:farmoish/features/auth/presentation/components/button/navigator_button.dart';
import 'package:farmoish/features/auth/presentation/screens/authhorization/registration/customer/registratiton_customer_page.dart';
import 'package:farmoish/features/auth/presentation/screens/authhorization/registration/courier/registratiton_courier_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class RegistrationRoleSelection extends ConsumerStatefulWidget {
  const RegistrationRoleSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationRoleSelectionState();
}

class _RegistrationRoleSelectionState
    extends ConsumerState<RegistrationRoleSelection> {
  @override
  Widget build(BuildContext context) {
    String? selectedRole;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                Spacer(),
                Column(
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
                      'Создайте свой аккаунт',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Выберите свою роль, чтобы начать',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      backgroundColor: Color(0xFF4AAB4E),
                      onPressed: () {
                        setState(() {
                          selectedRole = 'courier';
                        });
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => RegistratitonCourierPage(selectedRole: selectedRole!,),
                          ),
                        );
                      },
                      text: "Я курьер",
                    ),
                    SizedBox(height: 10),
                    NavigatorButton(
                      backgroundColor: Color(0xFF2196F3),
                      onPressed: () {
                        setState(() {
                          selectedRole = 'customer';
                        });
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => RegistratitonCustomerPage(selectedRole: selectedRole!),
                          ),
                        );
                      },
                      text: "Я клиент",
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Уже есть аккаунт? ', style: TextStyle()),
                    Text(
                      'Войти',
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        fontWeight: FontWeight.w900,
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
