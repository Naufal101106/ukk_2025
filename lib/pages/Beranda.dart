import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // padding:EdgeInsets.only(top: 40),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 195, 197, 205),
                Color.fromARGB(255, 78, 158, 195),
                Color.fromARGB(199, 6, 118, 170)
              ],
            ),
          ),
        ),
      ),
    );
  }
}