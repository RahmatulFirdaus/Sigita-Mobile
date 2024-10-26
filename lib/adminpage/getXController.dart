import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigita_final_project/adminpage/adminKategoriPage.dart';
import 'package:sigita_final_project/adminpage/adminMainPage.dart';
import 'package:sigita_final_project/adminpage/adminPostinganPage.dart';

class Getxcontrollerpage extends StatefulWidget {
  const Getxcontrollerpage({super.key});

  @override
  State<Getxcontrollerpage> createState() => _GetxcontrollerpageState();
}

class _GetxcontrollerpageState extends State<Getxcontrollerpage> {
  final NavigationController _navController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: _navController.screen[_navController.selectedIndex.value],

        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: _navController.selectedIndex.value,
          onDestinationSelected: (index) {
            _navController.updateIndex(index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_rounded), label: "Home"),
            NavigationDestination(icon: Icon(Icons.poll_sharp), label: "Postingan"),
            NavigationDestination(icon: Icon(Icons.polyline), label: "Kategori"),
          ],
        )));
  }
}

//merupakan sebuah class yang menyimpan dan mengelola indeks halaman dengan getx
class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screen = [
    const Adminmainpage(),
    const Adminpostinganpage(),
    const Adminkategoripage()
  ];

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}