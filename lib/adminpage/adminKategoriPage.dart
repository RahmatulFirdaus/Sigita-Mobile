import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigita_final_project/adminpage/edit_page/kategori.dart';
import 'package:sigita_final_project/adminpage/tambah_page/tambah_kategori.dart';
import 'package:sigita_final_project/models/adminModel.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return [
            // Header
            pw.Center(
              child: pw.Text(
                'Laporan Kategori',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),

            // Table
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1,
              ),
              columnWidths: {
                0: const pw.FlexColumnWidth(0.5), // No
                1: const pw.FlexColumnWidth(2), // Kategori
                2: const pw.FlexColumnWidth(1), // Jumlah Postingan
              },
              children: [
                // Table Header
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'No',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Kategori',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Jumlah Postingan',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // Table Data
                ...getKategoriList.map((data) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            data.id.toString(),
                            style: const pw.TextStyle(fontSize: 10),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            data.kategori,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            data.jumlahPostingan.toString(),
                            style: const pw.TextStyle(fontSize: 10),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ];
        },
      ),
    );

    try {
      final directory = await getApplicationCacheDirectory();
      final file = File("${directory.path}/laporan_kategori.pdf");
      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: ${e.toString()}')),
      );
    }
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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddKategori()),
              );
            },
          ),
        ],
      ),
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
                    source: MyDataSource(
                        getKategori: getKategoriList, context: context),
                    rowsPerPage: 10),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            generatePDF();
          },
          child: const Icon(
            Icons.picture_as_pdf,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
      DataCell(Text(kategori.jumlahPostingan)),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditKategori(id: kategori.id)));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text(
                      "Apakah Anda yakin ingin menghapus postingan ini?"),
                  actions: [
                    TextButton(
                      child: const Text("Batal"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("Hapus"),
                      onPressed: () async {
                        try {
                          await DeleteKategoriAdmin.deleteKategoriAdmin(
                              kategori.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data Berhasil Dihapus")),
                          );
                          await (context
                              .findAncestorStateOfType<
                                  _AdminkategoripageState>()
                              ?.fetchData());
                        } catch (e) {
                          // Menangani kesalahan saat menghapus data
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Error saat menghapus data: $e")),
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
