import 'package:flutter/material.dart';
import 'package:sigita_final_project/adminpage/edit_page/postingan.dart';
import 'package:sigita_final_project/models/adminModel.dart';

class Adminpostinganpage extends StatefulWidget {
  const Adminpostinganpage({super.key});

  @override
  State<Adminpostinganpage> createState() => _AdminpostinganpageState();
}

class _AdminpostinganpageState extends State<Adminpostinganpage> {
  List<GetPostinganAdmin> getPostingan = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final getPosting = await GetPostinganAdmin.getPostinganAdmin();
    setState(() {
      getPostingan = getPosting;
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
                  header: const Text("Tabel Postingan", textAlign: TextAlign.center,),
                  columns: const [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Judul")),
                    DataColumn(label: Text("Kategori")),
                    DataColumn(label: Text("File")),
                    DataColumn(label: Text("Deskripsi")),
                    DataColumn(label: Text("Jumlah Download")),
                    DataColumn(label: Text("Jumlah Komentar")),
                    DataColumn(label: Text("Aksi")),
                  ],
                  source: MyDataSource(getPostingan: getPostingan, context: context), // Pass context here
                  rowsPerPage: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<GetPostinganAdmin> getPostingan;
  final BuildContext context; // Add context as a member variable

  MyDataSource({required this.getPostingan, required this.context}); // Update constructor

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
      DataCell(Text(postingan.jumlah_download)),
      DataCell(Text(postingan.jumlah_komentar)),
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePostingan(id: postingan.id),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
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
