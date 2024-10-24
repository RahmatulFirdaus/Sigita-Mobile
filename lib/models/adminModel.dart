import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Adminmodel {
  String judul;
  IconData ikon;

  Adminmodel({required this.judul, required this.ikon});

  static List<Adminmodel> getAdminModel(){
    List<Adminmodel> adminList = [];

    adminList.add(Adminmodel(judul: "Jumlah Postingan", ikon: Icons.book));
    adminList.add(Adminmodel(judul: "Jumlah Pengunjung", ikon: Icons.analytics));
    adminList.add(Adminmodel(judul: "Jumlah Komentar", ikon: Icons.comment));
    return adminList;
  }
}

class GetTotalPostingan{
  String jumlah;

  GetTotalPostingan({required this.jumlah});

  static Future<GetTotalPostingan> getTotalPostingan() async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getTotalPostingan");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var user = jsonData["data"];
    return GetTotalPostingan(
      jumlah: user['jumlah'].toString()
    );
  }
}