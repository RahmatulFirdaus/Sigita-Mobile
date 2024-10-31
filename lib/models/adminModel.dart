import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Adminmodel {
  String judul;
  IconData ikon;

  Adminmodel({required this.judul, required this.ikon});

  static List<Adminmodel> getAdminModel() {
    List<Adminmodel> adminList = [];

    adminList.add(Adminmodel(judul: "Jumlah Postingan", ikon: Icons.book));
    adminList.add(Adminmodel(judul: "Jumlah Download", ikon: Icons.analytics));
    adminList.add(Adminmodel(judul: "Jumlah Komentar", ikon: Icons.comment));
    return adminList;
  }
}

class GetTotalPostingan {
  String jumlah, judul;

  GetTotalPostingan({required this.jumlah, required this.judul});

  static Future<List<GetTotalPostingan>> getTotalPostingan() async {
    Uri url = Uri.parse(
        "http://10.0.10.58:3000/api/getTotalPostinganDownloadKomentar");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetTotalPostingan(
        judul: user['table_name'],
        jumlah: user['total'].toString(),
      );
    }).toList();
  }
}

class GetPostinganAdmin {
  String id,
      title,
      content,
      date,
      category,
      jumlah_download,
      file,
      jumlah_komentar;

  GetPostinganAdmin({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    required this.jumlah_download,
    required this.file,
    required this.jumlah_komentar,
  });

  static Future<List<GetPostinganAdmin>> getPostinganAdmin() async {
    Uri url = Uri.parse("http://10.0.10.58:3000/api/getPostinganAdmin");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetPostinganAdmin(
        id: user['id'].toString(),
        title: user['judul'].toString(),
        file: user['file'],
        content: user['deskripsi'],
        date: user['tanggal'].toString(),
        category: user['kategori'],
        jumlah_download: user['jumlah_download'].toString(),
        jumlah_komentar: user['jumlah_komentar'].toString(),
      );
    }).toList();
  }
}

class GetKategoriAdmin {
  String id, kategori, jumlah_postingan;

  GetKategoriAdmin({
    required this.id,
    required this.kategori,
    required this.jumlah_postingan,
  });

  static Future<List<GetKategoriAdmin>> getKategoriAdmin() async {
    Uri url = Uri.parse("http://10.0.10.58:3000/api/getKategoriAdmin");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetKategoriAdmin(
        id: user['id'].toString(),
        kategori: user['kategori'],
        jumlah_postingan: user['total_postingan'].toString(),
      );
    }).toList();
  }
}

class UpdatePostinganAdmin {
  String judul, deskripsi, file;

  UpdatePostinganAdmin({
    required this.judul,
    required this.deskripsi,
    required this.file,
  });

  static Future<UpdatePostinganAdmin> updatePostinganAdmin(String id, String judul, String file, String deskripsi) async {
    Uri url = Uri.parse("http://10.0.10.58:3000/api/updatePostingan/$id");
    var hasilResponse = await http.patch(url, body: {
      "judul": judul,
      "file": file,
      "deskripsi": deskripsi,
    });
    var jsonData = jsonDecode(hasilResponse.body);
    return UpdatePostinganAdmin(
        judul: jsonData['judul'].toString(),
        file: jsonData['file'].toString(),
        deskripsi: jsonData['deskripsi'].toString());
  }
}

class DeletePostinganAdmin {
  String id;

  DeletePostinganAdmin({
    required this.id,
  });

  static Future<DeletePostinganAdmin> deletePostinganAdmin(String id) async {
    Uri url = Uri.parse("http://10.0.10.58:3000/api/deletePostingan/$id");
    var hasilResponse = await http.delete(url);
    var jsonData = jsonDecode(hasilResponse.body);
    return DeletePostinganAdmin(id: jsonData['id'].toString());
  }
}

class PostPostinganAdmin{
  String id, id_kategori, judul, file, deskripsi, tanggal;

  PostPostinganAdmin({
    required this.id,
    required this.id_kategori,
    required this.judul,
    required this.file,
    required this.deskripsi,
    required this.tanggal,
  });

  static Future<PostPostinganAdmin> postPostinganAdmin(String id_kategori, String judul, String file, String deskripsi, String tanggal) async {
    Uri url = Uri.parse("http://10.0.10.58:3000/api/uploadFileAdmin");
    var hasilResponse = await http.post(url, body: {
      "id_kategori": id_kategori,
      "judul": judul,
      "file": file,
      "deskripsi": deskripsi,
      "tanggal": tanggal,
    });
    var jsonData = jsonDecode(hasilResponse.body);
    return PostPostinganAdmin(
        id: jsonData['id'].toString(),
        id_kategori: jsonData['id_kategori'].toString(),
        judul: jsonData['judul'].toString(),
        file: jsonData['file'].toString(),
        deskripsi: jsonData['deskripsi'].toString(),
        tanggal: jsonData['tanggal'].toString());
  }
}
