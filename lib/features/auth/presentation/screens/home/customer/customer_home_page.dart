import 'package:farmoish/features/auth/data/datasource/firebase/auth/signout/sign_out.dart';
import 'package:farmoish/features/auth/presentation/screens/registration/registration_role_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerHomePage extends ConsumerStatefulWidget {
  const CustomerHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerHomePageState();
}

class _CustomerHomePageState extends ConsumerState<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Customer', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(signOutProvider.notifier).signOut();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => RegistrationRoleSelection(),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app, size: 25, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
