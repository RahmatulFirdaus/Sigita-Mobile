import 'dart:convert';
import 'package:http/http.dart' as http;

class GetSigita {
  String id, title, content, date, category, jumlah, file, idKategori;

  GetSigita({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    required this.jumlah,
    required this.file,
    required this.idKategori,
  });

  // Mengambil data tanpa validasi
  static Future<List<GetSigita>> connApi() async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getPostingan");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetSigita(
        id: user['id'].toString(),
        idKategori: user['id_kategori'].toString(),
        title: user['judul'],
        file: user['file'],
        content: user['deskripsi'],
        date: user['tanggal'],
        category: user['kategori'],
        jumlah: user['jmlh'].toString(),
      );
    }).toList();
  }

  static Future<GetSigita> connApiDetail(String id) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getPostinganDetail/$id");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var user = jsonData["data"][0];
    return GetSigita(
      id: user['id'].toString(),
      idKategori: user['id_kategori'].toString(),
      title: user['judul'],
      file: user['file'],
      content: user['deskripsi'],
      date: user['tanggal'].toString(),
      category: user['kategori'],
      jumlah: user['jmlh'].toString(),
    );
  }
}

class PostSigita {
  String idPostingan;
  String email, komentar;

  PostSigita({
    required this.idPostingan,
    required this.email,
    required this.komentar,
  });

  static Future<PostSigita> postSigita(
      String idPostingan, String email, String komentar) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/simpanKomentar");
    var hasilResponse = await http.post(
      url,
      body: {
        "id_postingan": idPostingan,
        "email": email,
        "komentar": komentar,
      },
    );
    var jsonData = jsonDecode(hasilResponse.body);
    return PostSigita(
      idPostingan: jsonData['id_postingan'].toString(),
      email: jsonData['email'].toString(),
      komentar: jsonData['komentar'].toString(),
    );
  }
}

class GetFile {
  String pdf;

  GetFile({required this.pdf});

  static Future<GetFile> getFile(String id) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getDownloadFile/$id");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var user = jsonData["data"];
    return GetFile(pdf: user['file']);
  }
}

class PermissionFile {
  String idPostingan, email;

  PermissionFile({
    required this.idPostingan,
    required this.email,
  });

  static Future<PermissionFile> postDownload(
      String idPostingan, String email) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/downloadModul");
    var hasilResponse = await http.post(
      url,
      body: {
        "id_postingan": idPostingan,
        "email": email,
      },
    );
    var jsonData = jsonDecode(hasilResponse.body);
    return PermissionFile(
      idPostingan: jsonData['id_postingan'].toString(),
      email: jsonData['email'].toString(),
    );
  }
}

class GetKategori {
  String kategori, id;

  GetKategori({required this.kategori, required this.id});

  static Future<List<GetKategori>> getKategori() async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getKategori");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetKategori(
        id: user['id'].toString(),
        kategori: user['kategori'],
      );
    }).toList();
  }
}

class GetKomentar {
  String idPostingan, email, komentar, tanggal;

  GetKomentar({
    required this.idPostingan,
    required this.email,
    required this.komentar,
    required this.tanggal,
  });

  static Future<List<GetKomentar>> getKomentar(String id) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getKomentar/$id");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var dataList = jsonData["data"] as List;
    return dataList.map((user) {
      return GetKomentar(
        idPostingan: user['id_postingan'].toString(),
        email: user['email'],
        komentar: user['komentar'],
        tanggal: user['tanggal'],
      );
    }).toList();
  }
}

class GetPesan {
  String pesan;

  GetPesan({required this.pesan});

  static Future<GetPesan> getPesan(String id) async {
    Uri url = Uri.parse("http://10.0.10.50:3000/api/getKomentar/$id");
    var hasilResponse = await http.get(url);
    var jsonData = jsonDecode(hasilResponse.body);
    var user = jsonData["pesan"];
    return GetPesan(pesan: user);
  }
}
