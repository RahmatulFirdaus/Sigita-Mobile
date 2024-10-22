import 'package:flutter/material.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';

class Faqpage extends StatelessWidget {
  const Faqpage({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/think.png"),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "Pertanyaan yang Sering Diajukan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              buildSection(
                icon: Icons.done_all,
                title: 'Apakah ada biaya untuk mengikuti modul di SIGITA',
                description:
                    "Beberapa modul di SIGITA gratis, namun ada juga modul premium yang memerlukan biaya. Informasi lebih lanjut mengenai biaya dapat dilihat pada halaman modul di situs web kami.",
              ),
              SizedBox(height: 20), // Menambahkan jarak antar section
              buildSection(
                icon: Icons.done_all,
                title:
                    'Bagaimana cara mendapatkan bantuan jika mengalami kesulitan?',
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              ),
              SizedBox(height: 20), // Menambahkan jarak antar section
              buildSection(
                icon: Icons.done_all,
                title: 'Apakah materi di SIGITA selalu diperbarui?',
                description:
                    "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate ",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(backgroundColor: const Color.fromARGB(255, 162, 213, 255), radius: 27),
              CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  radius: 21),
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 162, 213, 255),
                radius: 18,
                child: Icon(icon, size: 25, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          SizedBox(width: 10), // Jarak antara ikon dan teks
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 11), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
