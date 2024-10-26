import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sigita_final_project/pages/dashboard.dart';

class OpeningSplashScreen extends StatefulWidget {
  const OpeningSplashScreen({super.key});

  @override
  State<OpeningSplashScreen> createState() => _OpeningSplashScreenState();
}

class _OpeningSplashScreenState extends State<OpeningSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const DashboardPage())); // Ganti dengan halaman utama Anda
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color.fromRGBO(202, 248, 253, 1),
          ],
          begin: Alignment.topLeft, // Titik awal gradien
          end: Alignment.bottomRight, // Titik akhir gradien
        ),
      ),
      child: Center(
          child: AnimatedTextKit(animatedTexts: [
        TypewriterAnimatedText(
          'Welcome to Sigita',
          textStyle: const TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 7, 7, 7),
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 200),
        ),
      ])),
    ));
  }
}
