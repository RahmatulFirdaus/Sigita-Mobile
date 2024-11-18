import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigita_final_project/adminpage/getXController.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Row(
                    children: [
                      Text(
                        "Login Admin",
                        style: TextStyle(
                          fontSize: 45,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.warning_sharp,
                        color: Color.fromARGB(255, 255, 0, 0),
                        size: 50,
                      )
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text("Username",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5))),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(22, 0, 23, 0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text("Password",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5))),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(22, 0, 23, 0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 45,
              ),
              Container(
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 22),
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
                    } else if (usernameController.text == "admin" &&
                        passwordController.text == "admin123") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Getxcontrollerpage()));
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
                    backgroundColor: MaterialStatePropertyAll(
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8)),
                  ),
                  child: const Text(
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
