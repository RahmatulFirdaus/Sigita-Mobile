import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:sigita_final_project/models/adminModel.dart';
import 'package:sigita_final_project/models/sigitaModel.dart';

class AddPostingan extends StatefulWidget {
  const AddPostingan({super.key});

  @override
  State<AddPostingan> createState() => _AddPostinganState();
}

class _AddPostinganState extends State<AddPostingan> {
  TextEditingController judulController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  String? idKategori;
  List<GetKategori> dataKategori = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  File? _file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final getKategoriFetch = await GetKategori.getKategori();
    setState(() {
      dataKategori = getKategoriFetch;
    });
  }

  Future<String> _generateFileName(File file) async {
    Uint8List fileBytes = await file.readAsBytes();
    Digest hash = md5.convert(fileBytes);
    return hash.toString();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Proses asinkron dilakukan di luar setState
      _file = File(result.files.single.path!);
      String newFileName = await _generateFileName(_file!);

      // setState hanya digunakan untuk memperbarui UI
      setState(() {
        fileController.text = newFileName;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // Format the date and time as shown in your example
          String formattedDateTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
          tanggalController.text = formattedDateTime;
        });
      }
    }
  }

  Future<void> uploadFileWithFormData({
    required String id_kategori,
    required String judul,
    required String deskripsi,
    required String tanggal,
  }) async {
    if (_file == null) return;

    var uri = Uri.parse("http://10.0.10.58:3000/api/uploadFileAdmin");
    var request = http.MultipartRequest('POST', uri);

    // Tambahkan file ke dalam request
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _file!.path,
        filename: fileController.text,
      ),
    );

    request.fields['id_kategori'] = id_kategori;
    request.fields['judul'] = judul;
    request.fields['deskripsi'] = deskripsi;
    request.fields['tanggal'] = tanggal;
    
    var response = await request.send();

    if (response.statusCode == 200) {
      print("File and data uploaded successfully!");
    } else {
      print("Failed to upload file and data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Postingan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Judul",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: judulController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Kategori",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  value: idKategori,
                  hint: const Text("Pilih Kategori"),
                  items: dataKategori.map((GetKategori getKategori) {
                    return DropdownMenuItem<String>(
                      value: getKategori.id,
                      child: Text(getKategori.kategori),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idKategori = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "File",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: fileController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _file != null ? ' ${basename(_file!.path)}' : '',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              ElevatedButton(onPressed: _pickFile, child: Text('Pilih File')),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Deskripsi",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Tanggal",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: tanggalController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                  onTap: () => _selectDateTime(context),
                ),
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 131, 255, 135),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        try{
                          uploadFileWithFormData(
                              id_kategori: idKategori!,
                              judul: judulController.text,
                              deskripsi: deskripsiController.text,
                              tanggal: tanggalController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data Berhasil Tersimpan")),
                          );
                          Navigator.pop(context);
                        } catch(e){ 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Data Gagal Tersimpan")),
                          );
                        }
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
