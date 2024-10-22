import 'package:flutter/material.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navigasibar(),
        drawer: Drawernavigasi(),
        body: SingleChildScrollView(
          child: Container(
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 30),
                      child: Text(
                        "Selamat Datang di SIGITA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    buildSection(
                      icon: Icons.search,
                      title: 'Mengapa Memilih SIGITA',
                      description:
                          "SIGITA menawarkan berbagai modul pembelajaran yang mencakup semua aspek keperawatan, modul dirancang untuk interaktif dan mudah dipahami dan simulasi kasus nyata untuk membantu Andamenguasai materi dengan lebih baik. Akses Fleksibel memungkinkan Anda untuk mengatur waktu belajar sesuai dengan kebutuhan Anda.",
                    ),
                    buildSection(
                      icon: Icons.book,
                      title: 'Modul Pembelajaran Unggulan',
                      description:
                          "Dasar-dasar Keperawatan: Memahami anatomi manusia, terminologi medis, dan teknik dasar keperawatan \nKeperawatan Klinis: Teknik-teknik perawatan klinis, manajemen pasien, dan penanganan situasi darurat. Keperawatan Spesialis: Modul khusus untuk keperawatan anak, geriatri, komunitas, dan lainnya.",
                    ),
                    buildSection(
                      icon: Icons.support_agent,
                      title: 'Dukungan Ahli',
                      description:
                          "Dapatkan bimbingan dari para ahli dan praktisi keperawatan yang berpengalaman. Tim SIGITA siap membantu menjawab pertanyaan dan memberikan tips praktis tingkatkan pengetahuan dan keterampilan Anda untuk menjadi perawat yang kompeten dan percaya diri..",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Lihat Informasi Lebih Lanjut",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                      child: ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                "https://www.youtube.com/@rsjsambanglihum4612"));
                          },
                          child: Text(
                            "Cek Youtube Kami",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ])),
        ));
  }

  Widget buildSection(
      {required IconData icon,
      required String title,
      required String description}) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(backgroundColor: const Color.fromARGB(255, 162, 213, 255), radius: 27),
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 21),
                  CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 162, 213, 255),
                      radius: 18,
                      child: Icon(icon, size: 25, color: Colors.black)),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(description, style: TextStyle(color: Colors.black),textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
