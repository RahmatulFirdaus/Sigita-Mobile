import 'package:flutter/material.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';

class Masyarakatpage extends StatelessWidget {
  const Masyarakatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Navigasibar(),
        drawer: const Drawernavigasi(),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromRGBO(202, 248, 253, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_emotions,
                    size: 70,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Maaf ya! Postingan Tidak Tersedia",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ))));
  }
}
