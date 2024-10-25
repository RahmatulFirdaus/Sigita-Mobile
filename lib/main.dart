import 'package:flutter/material.dart';
import 'package:sigita_final_project/adminpage/getXController.dart';
import 'package:sigita_final_project/pages/openingSplashScreen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      title: "Sigita",
      // theme: ThemeData.light(),
      home: Getxcontrollerpage()
    );
  }
}
void restartApp(BuildContext context) {
    // Navigasi untuk mengganti semua rute dengan halaman baru (me-restart aplikasi)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
      (route) => false, // Menghapus semua rute
    );
  }