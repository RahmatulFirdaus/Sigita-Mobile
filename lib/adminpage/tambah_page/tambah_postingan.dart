import 'package:flutter/material.dart';

class AddPostingan extends StatefulWidget {
  const AddPostingan({super.key});

  @override
  State<AddPostingan> createState() => _AddPostinganState();
}

class _AddPostinganState extends State<AddPostingan> {
  TextEditingController judulController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Postingan'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Judul",
                  style: TextStyle(fontSize: 18),
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
                  "File",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: TextField(
                //   controller: fileController,
                //   decoration: const InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //     border: InputBorder.none,
                //   ),
                // ),
              ),
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
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
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
                      onPressed: () {
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}