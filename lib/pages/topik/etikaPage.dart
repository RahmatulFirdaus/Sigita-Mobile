import 'package:flutter/material.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';

class Etikapage extends StatelessWidget {
  const Etikapage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navigasibar(),
        drawer: Drawernavigasi(),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromRGBO(202, 248, 253, 1),
                ],
                begin: Alignment.topCenter, // Titik awal gradien
                end: Alignment.bottomCenter, // Titik akhir gradien
              ),
            ),
            child: Center(
                child: Text(
              "Postingan Tidak Ada",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ))));
  }
}
