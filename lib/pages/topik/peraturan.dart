import 'package:flutter/material.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';

class Peraturanpage extends StatelessWidget {
  const Peraturanpage({super.key});

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
                begin: Alignment.topCenter, // Titik awal gradien
                end: Alignment.bottomCenter, // Titik akhir gradien
              ),
            ),
            child: const Center(
                child: Text(
              "Postingan Tidak Ada",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ))));
  }
}
