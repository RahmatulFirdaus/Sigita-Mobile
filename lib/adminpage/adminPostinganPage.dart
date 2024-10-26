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
                  header: const Text(
                    "Tabel Postingan",
                    textAlign: TextAlign.center,
                  ),
                  columns: [
                    const DataColumn(label: Text("No")),
                    const DataColumn(label: Text("Judul")),
                    const DataColumn(label: Text("Kategori")),
                    const DataColumn(label: Text("File")),
                    const DataColumn(label: Text("Deskripsi")),
                    const DataColumn(label: Text("Jumlah Download")),
                    const DataColumn(label: Text("Jumlah Komentar")),
                    const DataColumn(label: Text("Aksi")),
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
  final BuildContext context;

  MyDataSource({required this.getPostingan, required this.context});

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
      DataCell(Text(postingan.jumlah_download.toString())), // Assuming this is a numeric value
      DataCell(Text(postingan.jumlah_komentar.toString())), // Assuming this is a numeric value
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text("Apakah Anda yakin ingin menghapus postingan ini?"),
                    actions: [
                      TextButton(
                        child: const Text("Batal"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text("Hapus"),
                        onPressed: () async {
                          Navigator.pop(context); // Menutup dialog
                          try {
                            await DeletePostinganAdmin.deletePostinganAdmin(postingan.id); // Menambahkan await
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data Berhasil Dihapus")),
                            );
                            // Refresh data setelah menghapus
                            await (context.findAncestorStateOfType<_AdminpostinganpageState>()?.fetchData());
                          } catch (e) {
                            // Menangani kesalahan saat menghapus data
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error saat menghapus data: $e")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
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
