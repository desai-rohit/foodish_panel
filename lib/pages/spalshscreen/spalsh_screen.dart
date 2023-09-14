import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/pages/user/loginpage.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    getcurrentEmail();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return currentEmail == null
                  ? const LoginPage()
                  : const BottomNav();
            })));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
          ],
        ),
      ),
    );
  }
}
