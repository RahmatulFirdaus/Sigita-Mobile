import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigita_final_project/adminpage/loginAdmin.dart';
import 'package:sigita_final_project/pages/dashboard.dart';
import 'package:sigita_final_project/models/sigitaModel.dart';
import 'package:sigita_final_project/pages/faqPage.dart';
import 'package:sigita_final_project/pages/topik/etikaPage.dart';
import 'package:sigita_final_project/pages/topik/peraturan.dart';
import 'package:sigita_final_project/pages/topik/kesehatanPage.dart';
import 'package:sigita_final_project/pages/topik/masyarakatPage.dart';

class Drawernavigasi extends StatefulWidget {
  const Drawernavigasi({super.key});

  @override
  State<Drawernavigasi> createState() => _DrawernavigasiState();
}

class _DrawernavigasiState extends State<Drawernavigasi> {
  List<GetKategori> dataKategori = [];
  List pageList = [
    {"halaman": const Kesehatanpage()},
    {"halaman": const Masyarakatpage()},
    {"halaman": const Etikapage()},
    {"halaman": const Peraturanpage()},
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    GetKategori.getKategori().then((nilai) {
      setState(() {
        dataKategori = nilai;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/rsj.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUqiWQ4-b3TjwWaS_4GtAEW8WZ3BVWmC5kNw&s",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Rumah Sakit Jiwa Sambang Lihum",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                "Dashboard",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const DashboardPage();
                  },
                ));
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.pageview_outlined),
              title: const Text("Topik"),
              children: dataKategori.map((kategori) {
                return ListTile(
                  title: Text(
                    kategori.kategori,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    _selectedIndex = dataKategori.indexOf(kategori);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                pageList[_selectedIndex]['halaman']));
                  },
                );
              }).toList(),
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: Text(
                "FAQ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Faqpage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: Text(
                "Admin Mode",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Loginadminpage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
