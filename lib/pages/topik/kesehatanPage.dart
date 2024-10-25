import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigita_final_project/drawerNav/drawerNavigasi.dart';
import 'package:sigita_final_project/models/sigitaModel.dart';
import 'package:sigita_final_project/pages/dashboard.dart';
import 'package:sigita_final_project/pages/secondPageKesehatan.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';

class Kesehatanpage extends StatefulWidget {
  const Kesehatanpage({super.key});

  @override
  State<Kesehatanpage> createState() => _KesehatanpageState();
}

class _KesehatanpageState extends State<Kesehatanpage> {
  List<GetSigita> dataRespon = [];
  List<GetKategori> dataKategori = [];
  List<GetSigita> filteredDataRespon = []; // New list for filtered results
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data on initialization
    GetSigita.connApi().then((value) {
      setState(() {
        dataRespon = value;
        filteredDataRespon = value;
      });
    });
    GetKategori.getKategori().then((nilai) {
      setState(() {
        dataKategori = nilai;
      });
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDataRespon = dataRespon;
      });
    } else {
      setState(() {
        filteredDataRespon = dataRespon
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()) ||
                item.content.toLowerCase().contains(query.toLowerCase()) ||
                item.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void resetSearch() {
    setState(() {
      searchController.clear();
      filteredDataRespon = dataRespon;
    });
  }

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
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 10.0,
                ),
              ]),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  debugPrint("Search value: $value");
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                  hintText: "Cari Disini",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.filter_list),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: filteredDataRespon.isNotEmpty
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          return PageView.builder(
                            controller: PageController(viewportFraction: 0.95),
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              var data = filteredDataRespon[index];
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: constraints.maxWidth * 1,
                                height: constraints.maxHeight,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(0, 10),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 1),
                                        child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(150),
                                          child: SizedBox(
                                            // width: 200,
                                            // height: 200,
                                            child: Image.asset(
                                              "images/redContent.png",
                                              width: 350,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          (data.title == null)
                                              ? "data tidak ada"
                                              : data.title,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Text(
                                          data.content,
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.poppins(
                                            textStyle:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      115, 0, 0, 0),
                                                  width: 2),
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageProposal(
                                                    id: data.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Open for Details",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        children: [
                                          Text(
                                            "Tanggal : ${data.date}",
                                            style: GoogleFonts.poppins(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            "Kategori : ${data.category}",
                                            style: GoogleFonts.poppins(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            " Jumlah Komentar : ${data.jumlah}",
                                            style: GoogleFonts.poppins(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: filteredDataRespon.length,
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded Content() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: filteredDataRespon.isNotEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.95),
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      var data = filteredDataRespon[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: constraints.maxWidth * 1,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(63, 236, 255, 1),
                                Colors.purple, // Warna akhir
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 10),
                              blurRadius: 40,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(150),
                                  child: SizedBox(
                                    // width: 200,
                                    // height: 200,
                                    child: Image.asset(
                                      "images/redContent.png",
                                      width: 350,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  (data.title == null)
                                      ? "data tidak ada"
                                      : data.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  data.content,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Color.fromARGB(115, 0, 0, 0),
                                          width: 2),
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PageProposal(
                                            id: data.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Open for Details",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Text(
                                    "Tanggal : ${data.date}",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Kategori : ${data.category}",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Jumlah : ${data.jumlah}",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: filteredDataRespon.length,
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Container SearchMenu() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 10.0,
        ),
      ]),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          debugPrint("Search value: $value");
          filterSearchResults(value);
        },
        decoration: InputDecoration(
          hintText: "Cari Disini",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.filter_list),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
