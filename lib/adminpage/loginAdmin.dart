import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigita_final_project/adminpage/adminMainPage.dart';

class Loginadminpage extends StatefulWidget {
  const Loginadminpage({super.key});

  @override
  State<Loginadminpage> createState() => _LoginadminpageState();
}

class _LoginadminpageState extends State<Loginadminpage> {
  var username = "Admin";
  var password = "Admin123";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 255, 255),
            const Color.fromARGB(255, 0, 0, 0)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Login Admin",
                  style: TextStyle(
                    fontSize: 45,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text("Username",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5))),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(22, 0, 23, 0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text("Password",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5))),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(22, 0, 23, 0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                    ),
                  )),
              SizedBox(
                height: 45,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: ElevatedButton(
                  onPressed: () {
                    //validasi saat username dan password kosong
                    if (usernameController.text == "" &&
                        passwordController.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter your username and password",
                          textColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 17, 0), //warna bg android
                          gravity: ToastGravity.BOTTOM, //posisi pada android
                          timeInSecForIosWeb: 3, //lama muncul pesan pada web
                          webPosition:
                              "center", //posisi pada web + kombinasi gravity
                          webBgColor: "white", //warna pada web
                          toastLength: Toast.LENGTH_LONG //lama muncul android
                          );
                      //validasi saat username kosong
                    } else if (usernameController.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter your username",
                          textColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 17, 0), //warna bg android
                          gravity: ToastGravity.BOTTOM, //posisi pada android
                          timeInSecForIosWeb: 3, //lama muncul pesan pada web
                          webPosition:
                              "center", //posisi pada web + kombinasi gravity
                          webBgColor: "white", //warna pada web
                          toastLength: Toast.LENGTH_LONG //lama muncul android
                          );
                      //validasi saat password kosong
                    } else if (passwordController.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter password",
                          textColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 17, 0), //warna bg android
                          gravity: ToastGravity.BOTTOM, //posisi pada android
                          timeInSecForIosWeb: 3, //lama muncul pesan pada web
                          webPosition:
                              "center", //posisi pada web + kombinasi gravity
                          webBgColor: "white", //warna pada web
                          toastLength: Toast.LENGTH_LONG //lama muncul android
                          );
                    } else if (usernameController.text == "" &&
                        passwordController.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter your username and password",
                          textColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 17, 0), //warna bg android
                          gravity: ToastGravity.BOTTOM, //posisi pada android
                          timeInSecForIosWeb: 3, //lama muncul pesan pada web
                          webPosition:
                              "center", //posisi pada web + kombinasi gravity
                          webBgColor: "white", //warna pada web
                          toastLength: Toast.LENGTH_LONG //lama muncul android
                          );
                    } else if (usernameController.text == "admin" &&
                        passwordController.text == "admin123") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Adminmainpage()));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Invalid username or password",
                          textColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 255, 17, 0), //warna bg android
                          gravity: ToastGravity.BOTTOM, //posisi pada android
                          timeInSecForIosWeb: 3, //lama muncul pesan pada web
                          webPosition:
                              "center", //posisi pada web + kombinasi gravity
                          webBgColor: "white", //warna pada web
                          toastLength: Toast.LENGTH_LONG //lama muncul android
                          );
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    backgroundColor:
                        MaterialStatePropertyAll(const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8)),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
