import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xff1565C0),

              Color(0xff42A5F5),

            ],

          ),

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Image.asset(
              "assets/logos/logo-backround.png",
              width: 150,
            ),

            const SizedBox(height: 25),
            const Text(

              "Connectez les artisans aux clients",

              style: TextStyle(

                color: Colors.white70,

                fontSize: 16,

              ),

            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(

              color: Colors.white,

            ),

          ],

        ),

      ),

    );
  }
}