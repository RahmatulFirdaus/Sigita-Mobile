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
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUqiWQ4-b3TjwWaS_4GtAEW8WZ3BVWmC5kNw&s",
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 90,
                          color: const Color.fromARGB(255, 255, 17, 0),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                "Dashboard",
                style: TextStyle(fontSize: 14),
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
              leading: const Icon(Icons.pageview),
              title: const Text("Topik", style: TextStyle(fontSize: 14)),
              children: dataKategori.map((kategori) {
                return ListTile(
                  title: Text(
                    kategori.kategori,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 14),
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
              leading: const Icon(Icons.question_answer),
              title: Text(
                "FAQ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Faqpage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: Text(
                "Admin Section",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Loginadminpage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
