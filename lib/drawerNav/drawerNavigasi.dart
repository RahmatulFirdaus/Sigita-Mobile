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
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/rsnew.png"), fit: BoxFit.cover),
            ),
            child: null,
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined, color: Colors.black),
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
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              leading: const Icon(
                Icons.topic_outlined,
                color: Colors.black,
              ),
              title: const Text("Topik", style: TextStyle(fontSize: 14)),
              children: dataKategori.map((kategori) {
                return Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    leading: Icon(
                      Icons.article_outlined,
                      color: Colors.black,
                    ),
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
                  ),
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.help_outline_outlined, color: Colors.black),
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
            leading: const Icon(Icons.admin_panel_settings_outlined,
                color: Colors.black),
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
    );
  }
}
