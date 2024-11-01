import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sigita_final_project/adminpage/edit_page/kategori.dart';
import 'package:sigita_final_project/adminpage/tambah_page/tambah_kategori.dart';
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

  Future<void> fetchData() async {
    final getKategoriFetch = await GetKategoriAdmin.getKategoriAdmin();
    setState(() {
      getKategoriList = getKategoriFetch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.black,
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddKategori()),
                );
            },
          ),
        ],),
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
                    columns: [
                      const DataColumn(label: Text("No")),
                      const DataColumn(label: Text("Kategori")),
                      const DataColumn(label: Text("Jumlah Postingan")),
                      const DataColumn(label: Text("Aksi"))
                    ],
                    source: MyDataSource(getKategori: getKategoriList, context: context),
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
  final BuildContext context;
  MyDataSource({required this.getKategori, required this.context});

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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditKategori(id: kategori.id)
              ));
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
                          try {
                            await DeleteKategoriAdmin.deleteKategoriAdmin(kategori.id); 
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data Berhasil Dihapus")),
                            );
                            await (context.findAncestorStateOfType<_AdminkategoripageState>()?.fetchData());
                          } catch (e) {
                            // Menangani kesalahan saat menghapus data
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error saat menghapus data: $e")),
                            );
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
            },
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
