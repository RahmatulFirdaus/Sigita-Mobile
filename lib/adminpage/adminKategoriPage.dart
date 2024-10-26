import 'package:flutter/material.dart';
import 'package:sigita_final_project/models/adminModel.dart';

class Adminkategoripage extends StatefulWidget {
  const Adminkategoripage({super.key});

  @override
  State<Adminkategoripage> createState() => _AdminkategoripageState();
}

class _AdminkategoripageState extends State<Adminkategoripage> {
  List<GetKategoriAdmin> getKategoriList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final getKategoriFetch = await GetKategoriAdmin.getKategoriAdmin();
    setState(() {
      getKategoriList = getKategoriFetch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: PaginatedDataTable(
                    header: const Text(
                      "Tabel Kategori",
                      textAlign: TextAlign.center,
                    ),
                    columns: const [
                      DataColumn(label: Text("No")),
                      DataColumn(label: Text("Kategori")),
                      DataColumn(label: Text("Jumlah Postingan")),
                      DataColumn(label: Text("Aksi"))
                    ],
                    source: MyDataSource(getKategori: getKategoriList),
                    rowsPerPage: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<GetKategoriAdmin> getKategori;

  MyDataSource({required this.getKategori});

  @override
  DataRow? getRow(int index) {
    if (index >= getKategori.length) return null;
    final kategori = getKategori[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(kategori.kategori)),
      DataCell(Text(kategori.jumlah_postingan)),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => getKategori.length;

  @override
  int get selectedRowCount => 0;
}
