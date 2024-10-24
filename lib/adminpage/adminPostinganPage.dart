import 'package:flutter/material.dart';
import 'package:sigita_final_project/models/sigitaModel.dart';

class Adminpostinganpage extends StatefulWidget {
  const Adminpostinganpage({super.key});

  @override
  State<Adminpostinganpage> createState() => _AdminpostinganpageState();
}

class _AdminpostinganpageState extends State<Adminpostinganpage> {
  List<GetSigita> getPostingan = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final getPosting = await GetSigita.connApi();
    setState(() {
      getPostingan = getPosting;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaginatedDataTable(
          header: Text("Tabel Postingan", textAlign: TextAlign.center,),
          columns: [
          DataColumn(label: Text("No")),
          DataColumn(label: Text("Judul")),
          DataColumn(label: Text("Kategori")),
          DataColumn(label: Text("File")),
          DataColumn(label: Text("Deskripsi")),
          // DataColumn(label: Text("Jumlah Download")),
          // DataColumn(label: Text("Komentar")),
          DataColumn(label: Text("Aksi")),
        ], source: MyDataSource(getPostingan: getPostingan), rowsPerPage: 10),
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<GetSigita> getPostingan;

  MyDataSource({required this.getPostingan});

  @override
  DataRow? getRow(int index) {
    if (index >= getPostingan.length) return null;

    final postingan = getPostingan[index];

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(postingan.title)),
      DataCell(Text(postingan.category)),
      DataCell(Text(postingan.file)),
      DataCell(Text(postingan.content)),
      DataCell(
        ElevatedButton(
          onPressed: () {
            // Implementasikan aksi hapus
          },
          child: Text("Hapus"),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => getPostingan.length;

  @override
  int get selectedRowCount => 0;
}