import 'package:farmoish/features/auth/presentation/components/button/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class RegistrationRoleSelection extends ConsumerStatefulWidget {
  const RegistrationRoleSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegistrationRoleSelectionState();
}

class _RegistrationRoleSelectionState extends ConsumerState<RegistrationRoleSelection> {
  @override
  Widget build(BuildContext context) {
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
                          'SwiftShip',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Choose your role to get started',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      backgroundColor: Color(0xFF4AAB4E),
                      onPressed: () {},
                      text: "I'm a Courier",
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      backgroundColor: Color(0xFF2196F3),
                      onPressed: () {},
                      text: "I'm a Customer",
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: TextStyle()),
                    Text(
                      'Log In',
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
