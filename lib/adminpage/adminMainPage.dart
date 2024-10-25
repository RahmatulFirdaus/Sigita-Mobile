import 'package:flutter/material.dart';
import 'package:sigita_final_project/adminpage/linechart/linechart.dart';
import 'package:sigita_final_project/models/adminModel.dart';

class Adminmainpage extends StatefulWidget {
  const Adminmainpage({super.key});

  @override
  State<Adminmainpage> createState() => _AdminmainpageState();
}

class _AdminmainpageState extends State<Adminmainpage> {
  List<Adminmodel> adminList = [];
  List<GetTotalPostingan> totalPostingan = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async{
    adminList = Adminmodel.getAdminModel();

    final totalPostinganInit = await GetTotalPostingan.getTotalPostingan();
    setState(() {
      totalPostingan = totalPostinganInit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Admin Management",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40),
              child: ListView.separated(
                clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${adminList[index].judul}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text("${totalPostingan[index].jumlah}", style: TextStyle(fontSize: 18),)
                                ]),
                          ),
                          Icon(
                            adminList[index].ikon,
                            size: 80,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 40),
                  itemCount: totalPostingan.length),
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Linechart(),
          )
        ],
      ),
      
    );
  }
}
