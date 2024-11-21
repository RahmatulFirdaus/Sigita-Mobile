import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigita_final_project/models/sigitaModel.dart';
import 'package:sigita_final_project/navigasi/navigasiBar.dart';
import 'package:sigita_final_project/pages/view.dart';
import 'package:url_launcher/url_launcher.dart';

class PageProposal extends StatefulWidget {
  final String id;
  const PageProposal({Key? key, required this.id}) : super(key: key);

  @override
  State<PageProposal> createState() => _PageProposalState();
}

class _PageProposalState extends State<PageProposal> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _downloadEmailController =
      TextEditingController();

  GetSigita dataRespon = GetSigita(
      id: "",
      title: "",
      content: "",
      file: "",
      date: "",
      category: "",
      jumlah: "",
      idKategori: "");
  GetFile dataFile = GetFile(pdf: "");
  List<GetKomentar> dataKomentar = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final responData = await GetSigita.connApiDetail(widget.id);
      final fileData = await GetFile.getFile(widget.id);
      final komentarData = await GetKomentar.getKomentar(widget.id);

      setState(() {
        dataRespon = responData;
        dataFile = fileData;
        dataKomentar = komentarData;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _submitComment() async {
    if (_emailController.text.isEmpty || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan Komentar harus diisi")),
      );
      return;
    }

    await PostSigita.postSigita(
        dataRespon.id, _emailController.text, _commentController.text);

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Komentar Berhasil Dimasukkan")),
    );

    // Optional: Clear text fields after submission
    _emailController.clear();
    _commentController.clear();
  }

  void _downloadPDF() async {
    if (_downloadEmailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Email Tidak Boleh Kosong"),
        ),
      );
      return;
    }

    await PermissionFile.postDownload(widget.id, _downloadEmailController.text);
    launchUrl(Uri.parse(dataFile.pdf));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navigasibar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildInfoRow(),
                  const SizedBox(height: 16),
                  _buildDescription(),
                  const SizedBox(height: 16),
                  _buildCommentSection(),
                  const SizedBox(height: 16),
                  _buildDownloadSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      dataRespon.title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoColumn(Icons.date_range, dataRespon.date, 'Tanggal'),
        _buildInfoColumn(Icons.book, dataRespon.category, 'Kategori'),
        _buildInfoColumn(Icons.accessibility_new, dataRespon.jumlah, 'Jumlah'),
      ],
    );
  }

  Widget _buildInfoColumn(IconData icon, String text, String label) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      dataRespon.content,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Komentar',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Komentar',
                      prefixIcon: const Icon(Icons.comment),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitComment,
                    child: const Text('Kirim Komentar'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCommentList(),
      ],
    );
  }

  Widget _buildCommentList() {
    return dataKomentar.isEmpty
        ? const Center(child: Text('Belum Ada Komentar'))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataKomentar.length,
            itemBuilder: (context, index) {
              var comment = dataKomentar[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(
                  comment.email ?? 'Anonim',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(comment.komentar ?? ''),
              );
            },
          );
  }

  Widget _buildDownloadSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Informasi Lebih Lanjut',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Download PDF'),
                          content: TextField(
                            controller: _downloadEmailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _downloadPDF();
                              },
                              child: const Text('Download'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Download PDF'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Viewpdfpage(
                            data: dataFile.pdf,
                          ),
                        ),
                      );
                    },
                    child: const Text('Lihat PDF'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
