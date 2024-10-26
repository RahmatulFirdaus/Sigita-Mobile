import 'package:flutter/material.dart';

class UpdatePostingan extends StatefulWidget {
  String id;
  UpdatePostingan({super.key, required this.id});

  @override
  State<UpdatePostingan> createState() => _UpdatePostinganState();
}

class _UpdatePostinganState extends State<UpdatePostingan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Postingan"),
      ),
      body: Column(
        children: [
          Text(widget.id),
        ],
      ),
    );
  }
}